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
			'titre: formatted',
			'description: formatted',
			'image',
			'theme',
			'twitter-url: formatted',
			'twitter-user: formatted',
			'twitter-site-domain: formatted',
			'facebook-url: formatted',
			'facebook-page-id: formatted',
			'vimeo-url: formatted',
			'instagram-url: formatted',
			'youtube-url: formatted',
			'navigateurs-non-supportes: formatted',
		);
		

		public function __construct($env=NULL, $process_params=true) {
			parent::__construct($env, $process_params);
			$this->_dependencies = array();
		}

		public function about() {
			return array(
				'name' => 'Site: Config',
				'author' => array(
					'name' => 'Deux Huit Huit',
					'website' => 'https://deuxhuithuit.com',
					'email' => 'open-source@deuxhuithuit.com'
				),
				'version' => 'Symphony 2.6.x',
				'release-date' => '2016-11-22T16:36:22+00:00'
			);
		}

		public function getSource() {
			return '1';
		}

		public function allowEditorToParse() {
			return false;
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
