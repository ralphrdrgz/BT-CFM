/**
 * My Utility Functions
 */
component output="false" {

	public string function titleCase( required string str ) {
		return listToArray( arguments.str, " " )
			.map( ( word ) => word.len() ? uCase( word.left( 1 ) ) & lCase( word.right( -1 ) ) : word )
			.toList( " " );
	}

}
