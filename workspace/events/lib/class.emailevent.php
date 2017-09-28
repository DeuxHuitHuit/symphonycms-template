<?php

if(!defined('__IN_SYMPHONY__')) die('<h2>Error</h2><p>You cannot directly access this file</p>');

require_once('class.filterableevent.php');

class EmailEventException extends Exception
{
}

abstract class EmailEvent extends FilterableEvent
{
    protected abstract function getSubject();
    
    protected abstract function getBody();
    
    protected abstract function getFromName();
    
    protected abstract function getFromEmail();
    
    protected abstract function getRootElement();
    
    protected abstract function getActionKey();
    
    protected abstract function getReceipients();
    
    public function ignoreRolePermissions()
    {
        return true;
    }
    
    protected function throw404WhenNotTriggered()
    {
        return false;
    }
    
    protected function getSenderEmail()
    {
        return $this->getFromEmail();
    }
    
    protected function isValid()
    {
        return true;
    }
    
    public static function getSource()
    {
        return 'Symphony';
    }
    
    protected function cancel()
    {
        return false;
    }
    
    public function load()
    {
        if (isset($_POST['action'][$this->getActionKey()])) {
            return $this->trigger();
        }
        else if ($this->throw404WhenNotTriggered()) {
            throw new FrontendPageNotFoundException();
        }
        return false;
    }
    
    protected function trigger()
    {
        $r = new XMLElement($this->getRootElement());
        try {
            if ($this->cancel()) {
                return;
            }
            if ($this->isValid()) {
                if ($this->sendEmail()) {
                    $r->setAttribute('success', 'yes');
                } else {
                    throw new EmailEventException('Error sending email');
                }
            } else {
                throw new EmailEventException('Form is invalid');
            }
        } catch(Exception $ex) {
            $xmlEx = new XMLElement('error');
            
            $showMsg = $ex instanceof EmailEventException || Symphony::Engine()->isLoggedIn();
            $errorMessage = $showMsg ? $ex->getMessage() : __('A Fatal error occured');
            
            $xmlEx->setValue($errorMessage); 
            
            $r->appendChild($xmlEx);
            
            $r->setAttribute('success', 'no');
            
            Symphony::Log()->pushExceptionToLog($ex, true);
        }

        return $r;
    }

    private function sendEmail()
    {
        $email = Email::create();
        $email->setSenderEmailAddress($this->getSenderEmail());
        $email->setFrom($this->getFromEmail(), $this->getFromName());
        $email->setReplyToEmailAddress($this->getFromEmail());
        $email->setRecipients($this->getReceipients());
        $email->setSubject($this->getSubject());
        $email->setTextPlain($this->getBody()); 
        
        return $email->validate() && $email->send();
    }
    
    protected final function getHTTPInfos()
    {
        $infos = 'Site Language: '  . General::sanitize( $_POST['fl-language'] ) . PHP_EOL;
        $infos .= 'Referer: '       . General::sanitize( $_SERVER['HTTP_REFERER'] ) . PHP_EOL;
        $infos .= 'User-Agent: '    . General::sanitize( $_SERVER['HTTP_USER_AGENT'] ) . PHP_EOL;
        $infos .= 'IP: '            . General::sanitize( $_SERVER['REMOTE_ADDR'] ) . PHP_EOL;
        $infos .= 'HTTP Method: '   . General::sanitize( $_SERVER['REQUEST_METHOD'] ) . PHP_EOL;
        $infos .= 'Request URI: '   . General::sanitize( $_SERVER['REQUEST_URI'] ) . PHP_EOL;
        $infos .= 'Request time: '  . General::sanitize( $_SERVER['REQUEST_TIME'] ) . PHP_EOL;
        $infos .= 'CF IP: '         . General::sanitize( $_SERVER['HTTP_CF_CONNECTING_IP'] ) . PHP_EOL;
        $infos .= 'CF Country : '   . General::sanitize( $_SERVER['HTTP_CF_IPCOUNTRY'] ) . PHP_EOL;
        
        return $infos;
    }

}
