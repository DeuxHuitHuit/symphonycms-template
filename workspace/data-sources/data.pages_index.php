<?php

class datasourcepages_index extends SectionDatasource
{
    public $dsParamROOTELEMENT = 'pages-index';
    public $dsParamORDER = 'desc';
    public $dsParamPAGINATERESULTS = 'yes';
    public $dsParamLIMIT = '1';
    public $dsParamSTARTPAGE = '1';
    public $dsParamREDIRECTONEMPTY = 'no';
    public $dsParamREDIRECTONFORBIDDEN = 'no';
    public $dsParamREDIRECTONREQUIRED = 'no';
    public $dsParamNEGATEPARAM = '$handle';
    public $dsParamPARAMXML = 'no';
    public $dsParamSORT = 'system:id';
    public $dsParamHTMLENCODE = 'no';
    public $dsParamASSOCIATEDENTRYCOUNTS = 'no';

    public $dsParamFILTERS = array(
        '36' => '{$login-filter}',
        '183' => 'Index',
    );

    public $dsParamINCLUDEDELEMENTS = array(
        'title: formatted',
        'slug: all-languages: formatted',
        'modules: *',
        'accessible',
        'allow-indexing',
        'use-as',
        'share-image',
        'share-title: formatted',
        'share-description: formatted'
    );

    public function __construct($env = null, $process_params = true)
    {
        parent::__construct($env, $process_params);
        $this->_dependencies = array();
    }

    public function about()
    {
        return array(
            'name' => 'Pages: Index',
            'author' => array(
                'name' => 'Vincent Rouleau',
                'website' => 'https://starterkit.288dev.com',
                'email' => 'vincent@deuxhuithuit.com'),
            'version' => 'Symphony 4.0.0',
            'release-date' => '2019-07-15T18:33:11+00:00'
        );
    }

    public function getSource()
    {
        return '6';
    }

    public function allowEditorToParse()
    {
        return true;
    }
}