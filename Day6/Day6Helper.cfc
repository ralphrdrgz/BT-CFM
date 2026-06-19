/**
 * Helpers
 */
component output="false" {

	public array function queryToArray( required query data ) {
		local.columns = listToArray( arguments.data.columnList );
		local.queryArray = [];

		for ( local.rowIndex = 1; local.rowIndex <= arguments.data.recordCount; local.rowIndex++ ) {
			local.row = {};

			for ( local.columnIndex = 1; local.columnIndex <= arrayLen( local.columns ); local.columnIndex++ ) {
				local.columnName = local.columns[ local.columnIndex ];
				local.row[ local.columnName ] = arguments.data[ local.columnName ][ local.rowIndex ];
			}

			arrayAppend( local.queryArray, local.row );
		}

		return local.queryArray;
	}

	/**
	 * Converts datetime value to ISO8601 string format
	 */
	public string function getIsoTimeString( required date datetime, boolean convertToUTC = true ) {
		if ( convertToUTC ) {
			datetime = dateConvert( "local2utc", datetime );
		}

		return dateFormat( datetime, "yyyy-mm-dd" ) & "T" & timeFormat( datetime, "HH:nn:ss" ) & "Z";
	}

	/**
	 * Format the inputs as a range string "min - max"
	 *
	 * @param min The value to use as the minimum value
	 * @param max The value to use as the maximum value
	 * @param numberPrefix An optional string to prefix to each of the number values in the range
	 */
	public string function rangeString(
		required min,
		max = "",
		string numberPrefix = ""
	) {
		if ( !isNumeric( arguments.min ) ) {
			arguments.min = 0;
		}

		var getMask = function( required numeric value, string prefix = "" ) {
			var decimal = this.getDecimal( arguments.value );
			var mask = arguments.prefix & ",";

			if ( decimal > 0 ) {
				mask &= "." & repeatString( "9", len( decimal ) );
			}

			return mask;
		};

		if ( !arguments.keyExists( "max" ) || !isNumeric( arguments.max ) || arguments.min == arguments.max ) {
			return numberFormat( arguments.min, getMask( arguments.min, arguments.numberPrefix ) );
		}

		// Fix order of values in case they are swapped
		var values = arrayFilter( [ arguments.min, arguments.max ], ( item ) => isNumeric( item ) );

		arguments.min = values.min();
		arguments.max = values.max();

		arguments.min = numberFormat( arguments.min, getMask( arguments.min, arguments.numberPrefix ) );
		arguments.max = numberFormat( arguments.max, getMask( arguments.max, arguments.numberPrefix ) );

		return "#arguments.min# - #arguments.max#";
	}

	/**
	 * Returns the decimal from a number
	 *
	 * @param value A number to get the decimals from
	 */
	public numeric function getDecimal( required numeric value ) {
		return toString( arguments.value - fix( arguments.value ) ).replaceFirst( "^0?\.", "" );
	}

	/**
	 * Removes HTML tags from string
	 *
	 * @param value The string you want to remove HTML tags from
	 */
	public string function stripTags( required string value ) {
		return sanitizeHTML( arguments.value ).reReplace( "<[^>]*(?:>|$)", "", "ALL" );
	}

	/**
	 * Allows you to specify the mask you want added to your phone number.
	 * v2 - code optimized by Ray Camden
	 * v3.01
	 * v3.02 added code for single digit phone numbers from John Whish
	 * v4 make a default format - by James Moberg
	 *
	 * @see     https://cflib.org/udf/phoneFormat
	 * @param   varInput      Phone number to be formatted. (Required)
	 * @param   varMask      Mask to use for formatting. x represents a digit. Defaults to (xxx) xxx-xxxx (Optional)
	 * @author  Derrick Rapley (adrapley@rapleyzone.com)
	 * @version 4, February 11, 2011
	 *
	 * @return Returns a string.
	 */
	public string function phoneFormat( required string varInput, string mask ) {
		var curPosition = "";
		var i = "";
		var varMask = "(xxx) xxx-xxxx";
		var newFormat = "";
		var startPattern = "";

		if ( arguments.keyExists( "mask" ) && arguments.mask.len() ) {
			varMask = arguments.mask;
		}

		newFormat = trim( reReplace( varInput, "[^[:digit:]]", "", "all" ) );
		startPattern = reReplace( listFirst( varMask, "- " ), "[^x]", "", "all" );

		if ( len( newFormat ) >= len( startPattern ) ) {
			varInput = trim( varInput );
			newFormat = " " & reReplace( varInput, "[^[:digit:]]", "", "all" );
			newFormat = reverse( newFormat );
			varMask = reverse( varMask );

			for ( i = 1; i <= len( trim( varMask ) ); i = i + 1 ) {
				curPosition = mid( varMask, i, 1 );

				if ( curPosition != "x" ) {
					newFormat = insert( curPosition, newFormat, i - 1 ) & " ";
				}
			}

			newFormat = reverse( newFormat );
			varMask = reverse( varMask );
		}

		return trim( newFormat );
	}

	/**
	 * An "enhanced" version of ParagraphFormat.
	 * Added replacement of tab with nonbreaking space char, idea by Mark R Andrachek.
	 * Rewrite and multiOS support by Nathan Dintenfas.
	 *
	 * @param   string      The string to format. (Required)
	 * @author  Ben Forta (ben@forta.com)
	 * @version 3, June 26, 2002
	 *
	 * @return Returns a string.
	 */
	public function paragraphFormat( str ) {
		return str
			// first make Windows style into Unix style
			.replace( chr( 13 ) & chr( 10 ), chr( 10 ), "ALL" )
			// now make Macintosh style into Unix style
			.replace( chr( 13 ), chr( 10 ), "ALL" )
			// now fix tabs
			.replace( chr( 9 ), "&nbsp;&nbsp;&nbsp;", "ALL" )
			// now return the text formatted in HTML
			.replace( chr( 10 ), "<br>", "ALL" );
	}

	public function getGoogleStaticMapImageForLocation( required string location ) {
		var markerIconUrl = request.url.to( "/images/theme/map-icons/map-marker.png?v=64" );

		var locationMarker = new components.googlemaps.staticmap.Marker( location )
			.setIcon( markerIconUrl )
			.setScale( 2 );

		return new components.googlemaps.staticmap.GoogleStaticMap( request.siteSettings.GoogleMapApiKey )
			.setSigningSecret( request.siteSettings.googleMapsUrlSigningSecret )
			.setMapId( request.siteSettings.googleStaticMapID )
			.setZoom( 15 )
			.addMarker( locationMarker );
	}

	public numeric function getEstimatedMonthlyPayment(
		required numeric purchasePrice,
		required numeric annualInterestRate,
		required numeric loanTermYears,
		required numeric downPaymentPercentage
	) {
		var monthlyInterestRate = ( arguments.annualInterestRate / 100 ) / 12;
		var numberOfPayments = arguments.loanTermYears * 12;
		var downPaymentAmount = arguments.purchasePrice * ( arguments.downPaymentPercentage / 100 );
		var loanAmount = arguments.purchasePrice - downPaymentAmount;

		if ( monthlyInterestRate == 0 ) {
			return loanAmount / numberOfPayments;
		}

		return ( loanAmount * monthlyInterestRate ) / ( 1 - ( 1 + monthlyInterestRate ) ^  - numberOfPayments );
	}

}
