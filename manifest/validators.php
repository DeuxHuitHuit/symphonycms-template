<?php

	// See symphony/lib/toolkit/utils.validators.php
	
	$validators = array(
		'number' => '/^-?(?:\d+(?:\.\d+)?|\.\d+)$/i',
		'email' => '/^\w(?:\.?[\w%+-]+)*@\w(?:[\w-]*\.)+?[a-z]{2,}$/i',
		'URI' => '/^[^\s:\/?#]+:(?:\/{2,3})?[^\s.\/?#]+(?:\.[^\s.\/?#]+)*(?:\/?[^\s?#]*\??[^\s?#]*(#[^\s#]*)?)?$/',
	);

	$upload = array(
		'image' => '/\.(?:jpe?g|png)$/i',
		'image-all' => '/\.(?:bmp|gif|jpe?g|png)$/i',
		'document' => '/\.(?:docx?|pdf)$/i',
		'document-all' => '/\.(?:docx?|pdf|rtf|txt)$/i',
	);