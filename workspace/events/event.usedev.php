<?php

if(!defined('__IN_SYMPHONY__')) die('<h2>Error</h2><p>You cannot directly access this file</p>');

class eventUseDev extends Event
{
	public static function about()
	{
		return array(
			'name' => 'Use dev',
			'author' => array(
				'name' => 'Deux Huit Huit',
				'website' => 'https://deuxhuithuit.com',
				'email' => 'open-source (at) deuxhuithuit (dot) com',
			),
			'version' => '2.0.0',
			'release-date' => '2017-16-12',
			'trigger-condition' => '?use-dev or an already valid use-dev cookie',
			'recognised-fields' => array(
				array('use-dev', true),
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
		return new XMLElement('p', 'This is an event that will look for the ?use-dev query string or the use-dev cookie. If found, it will set the cookie for this request and output proper data into the xml');
	}

	protected function __trigger()
	{
		if (!class_exists('Frontend', false)) {
			return false;
		}
		$isQuery = isset($_GET['use-dev']);
		$cookieName = __SYM_COOKIE_PREFIX__ . 'use-dev';
		$isCookie = isset($_COOKIE[$cookieName]);
		$cookieTime = 2123798400;
		$domain = Session::getDomain();
		$deux88dev = '.288dev.com';

		if (strpos($domain, $deux88dev) !== false) {
			$domain = $deux88dev;
		}

		if ($isQuery) {
			if ($_GET['use-dev'] === 'no') {
				$cookieTime = time() - 3600;
				$isQuery = false;
				$isCookie = false;
			}

			setcookie(
				$cookieName,
				'1',
				$cookieTime,
				__SYM_COOKIE_PATH__,
				$domain,
				defined(__SECURE__) && __SECURE__,
				true
			);
		}

		Frontend::Page()->_param['use-dev'] =  $isQuery || $isCookie ? 'yes' : 'no';
		return $result;

	}
}
