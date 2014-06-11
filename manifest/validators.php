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
		'video-mp4' => '/\.(?:mp4|m4v)$/i',
		'video-ogv' => '/\.(?:ogv|ogg)$/i',
		'video-webm' => '/\.(?:webm|webmv)$/i',
		'video-all' => '/\.(?:mp4|m4v|ogv|ogg|webm|webmv)$/i',
		'audio-mp3' => '/\.(?:mp3)$/i',
		'audio-oga' => '/\.(?:oga|ogg)$/i',
		'audio-webm' => '/\.(?:webm|webma)$/i',
		'audio-all' => '/\.(?:mp3|ogv|oga|webm|webma)$/i',
	);