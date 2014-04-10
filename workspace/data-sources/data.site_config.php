<?php

	require_once(TOOLKIT . '/class.datasource.php');

	Class datasourcesite_config extends SectionDatasource {

		public $dsParamROOTELEMENT = 'site-config';
		public $dsParamORDER = 'desc';
		public $dsParamPAGINATERESULTS = 'yes';
		public $dsParamLIMIT = '1';
		public $dsParamSTARTPAGE = '1';
		public $dsParamREDIRECTONEMPTY = 'no';
		public $dsParamSORT = 'system:id';
		public $dsParamASSOCIATEDENTRYCOUNTS = 'no';
		
		
		public $dsParamINCLUDEDELEMENTS = array(
				'site-titre: formatted',
				'site-titre: formatted: all-languages',
				'description: formatted',
				'image-partage',
				'twitter-url: unformatted',
				'twitter-user: formatted',
				'twitter-site-domain: formatted',
				'facebook-url: formatted',
				'vimeo-url: formatted',
				'instagram-url: formatted',
				'navigateurs-non-supportes-titre: formatted',
				'navigateurs-non-supportes-texte: formatted',
				'navigateurs-non-supportes-poursuivre: formatted'
		);
		

		public function __construct($env=NULL, $process_params=true) {
			parent::__construct($env, $process_params);
			$this->_dependencies = array();
		}

		public function about() {
			return array(
				'name' => 'Site Config',
				'author' => array(
					'name' => 'Nicolas Brassard',
					'website' => 'http://pm.288dev.com',
					'email' => 'n@deuxhuithuit.com'),
				'version' => 'Symphony 2.3.6',
				'release-date' => '2014-03-04T16:36:22+00:00'
			);
		}

		public function getSource() {
			return '1';
		}

		public function allowEditorToParse() {
			return true;
		}

		public function execute(array &$param_pool = null) {
			$result = new XMLElement($this->dsParamROOTELEMENT);

			try{
				$result = parent::execute($param_pool);
			}
			catch(FrontendPageNotFoundException $e){
				// Work around. This ensures the 404 page is displayed and
				// is not picked up by the default catch() statement below
				FrontendPageNotFoundExceptionHandler::render($e);
			}
			catch(Exception $e){
				$result->appendChild(new XMLElement('error', $e->getMessage() . ' on ' . $e->getLine() . ' of file ' . $e->getFile()));
				return $result;
			}

			if($this->_force_empty_result) $result = $this->emptyXMLSet();

			return $result;
		}

	}
