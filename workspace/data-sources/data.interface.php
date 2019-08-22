<?php

class datasourceinterface extends SectionDatasource
{
    public $dsParamROOTELEMENT = 'interface';
    public $dsParamORDER = 'desc';
    public $dsParamPAGINATERESULTS = 'no';
    public $dsParamLIMIT = '20';
    public $dsParamSTARTPAGE = '1';
    public $dsParamREDIRECTONEMPTY = 'no';
    public $dsParamREDIRECTONFORBIDDEN = 'no';
    public $dsParamREDIRECTONREQUIRED = 'no';
    public $dsParamPARAMXML = 'no';
    public $dsParamSORT = 'system:id';
    public $dsParamHTMLENCODE = 'no';
    public $dsParamASSOCIATEDENTRYCOUNTS = 'no';

    public $dsParamINCLUDEDELEMENTS = array(
        'copy: formatted',
        'copy-success: formatted',
        'share-desktop: formatted',
        'share-mobile: formatted'
    );

    public function __construct($env = null, $process_params = true)
    {
        parent::__construct($env, $process_params);
        $this->_dependencies = array();
    }

    public function about()
    {
        return array(
            'name' => 'Interface',
            'author' => array(
                'name' => 'Vincent Rouleau',
                'website' => 'https://starterkit.288dev.com',
                'email' => 'vincent@deuxhuithuit.com'),
            'version' => 'Symphony 4.0.0',
            'release-date' => '2019-07-31T14:57:19+00:00'
        );
    }

    public function getSource()
    {
        return '32';
    }

    public function allowEditorToParse()
    {
        return true;
    }
}