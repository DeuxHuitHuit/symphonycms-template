<?php
	//require_once(EXTENSIONS . '/page_lhandles/lib/class.datasource.MultilingualNavigation.php');

	Class datasourcepages extends /*Multilingual*/NavigationDatasource{
	
		public $dsParamROOTELEMENT = 'pages';
		public $dsParamORDER = 'desc';
		public $dsParamREDIRECTONEMPTY = 'no';
		
		
		public function __construct($env=NULL, $process_params=true) {
			parent::__construct($env, $process_params);
			$this->_dependencies = array();
		}
		
		public function about() {
			return array(
				'name' => 'Site: Pages',
				'author' => array(
					'name' => 'Deux Huit Huit',
					'website' => 'http://deuxhuithuit.com',
					'email' => 'open-source (at) deuxhuithuit.com'),
				'version' => 'Symphony 2.4.x',
				'release-date' => '2013-10-24T16:31:27+00:00'
			);
		}
		
		public function getSource() {
			return 'navigation';
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
