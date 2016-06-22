<?php

if(!defined('__IN_SYMPHONY__')) die('<h2>Error</h2><p>You cannot directly access this file</p>');

class eventUsebuild extends Event
{
	public static function about()
	{
		return array(
			'name' => 'Use build cookie',
			'author' => array(
				'name' => 'Deux Huit Huit',
				'website' => 'https://deuxhuithuit.com',
				'email' => 'open-source (at) deuxhuithuit (dot) com',
			),
			'version' => '1.0.0',
			'release-date' => '2016-06-22',
			'trigger-condition' => '?use-build or an already valid use-build cookie',
			'recognised-fields' => array(
				array('use-build', true),
			)
		);
	}

	public static function getSource()
	{
		return 'Symphony';
	}

	public function load()
	{
		return $this->__trigger();
	}

	public static function documentation()
	{
		return new XMLElement('p', 'This is an event that will look for the ?use-build query string or the use-build cookie. If found, it will set the cookie for this request and output proper data into the xml');
	}

	protected function __trigger()
	{
		if (!class_exists('Frontend', false)) {
			return false;
		}
		$isQuery = isset($_GET['use-build']);
		$cookieName = __SYM_COOKIE_PREFIX__ . 'use-build';
		$isCookie = isset($_COOKIE[$cookieName]);

		if ($isQuery || $isCookie) {
			setcookie(
				$cookieName,
				'1',
				2123798400,
				__SYM_COOKIE_PATH__,
				Session::getDomain(),
				defined(__SECURE__) && __SECURE__,
				true
			);
		}

		Frontend::Page()->_param['use-build'] =  $isQuery || $isCookie ? 'yes' : 'no';
		return $result;

	}
}
