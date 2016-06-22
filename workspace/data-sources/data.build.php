<?php

	require_once(DATASOURCES . '/lib/class.json.datasource.php');

	Class datasourcebuild extends JSONDataSource {

		public $dsParamROOTELEMENT = 'build';

		public function __construct($env=NULL, $process_params=true) {
			parent::__construct($env, $process_params);
			$this->_dependencies = array();
		}

		public function about() {
			return array(
				'name' => 'Site: Build',
				'author' => array(
					'name' => 'Deux Huit Huit',
					'website' => 'http://deuxhutihuit.com',
					'email' => 'open-source@deuxhuithuit.com'),
				'version' => 'Symphony 2.7.x',
				'release-date' => '2016-21-12T19:25:30+00:00'
			);
		}

		protected function getJSONFilePath() {
			return WORKSPACE . '/assets/build.json';
		}
		
		protected function decode(XMLElement &$result, array $json) {
			$result = new XMLElement($this->dsParamROOTELEMENT);
			
			if (isset($json['lastBuild'])) {
				$result->appendChild(new XMLElement('last', $json['lastBuild']));
			}
			
			return $result;
		}

	}
