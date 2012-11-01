<?php

	if(!defined('__IN_SYMPHONY__')) die('<h2>Error</h2><p>You cannot directly access this file</p>');

	require_once(TOOLKIT . '/class.event.php');

	abstract Class EmailEvent extends Event {
		
		protected abstract function getSubject();
		
		protected abstract function getBody();
		
		protected abstract function getFromName();
		
		protected abstract function getFromEmail();
		
		protected abstract function getRootElement();
		
		protected abstract function getReceipients();
		
		public function load() {
			if (isset($_POST['action']['send-email'])) {
				return $this->__trigger();	
			}
			return false;
		}
		
		protected function __trigger(){
			$result = new XMLElement($this->getRootElement());
			try {

				if ($this->__sendEmail()) {
					$result->setAttribute("result", "success");
				} else {
					throw new Exception('Email was not valid');
				}
				
			} catch(Exception $e) {
				$result->setAttribute("result", "error");
				$result->appendChild(new XMLElement('error',$e->getMessage()));
			}

			return $result;
		}

		private function __sendEmail() {

			$email = Email::create();
			$email->setSenderEmailAddress($this->getReceipients());
			$email->setFrom($this->getFromEmail(), $this->getFromName());
			$email->setReplyToEmailAddress($this->getFromEmail());
			$email->setRecipients($RECIPIENTS);
			$email->setSubject($this->getSubject());
			$email->setTextPlain($this->getBody()); 
			
			if ($email->validate()) {
				$email->send();
			} else {
				return false;
			}
			
			return true;
		}
		
		protected final function getHTTPInfos() {
			$infos =  'Referer: ' 		. General::sanitize( $_SERVER['HTTP_REFERER'] ) . PHP_EOL;
			$infos .= 'User-Agent: '	. General::sanitize( $_SERVER['HTTP_USER_AGENT'] ) . PHP_EOL;
			$infos .= 'IP: '			. General::sanitize( $_SERVER['REMOTE_ADDR'] ) . PHP_EOL;
			$infos .= 'HTTP Method: '	. General::sanitize( $_SERVER['REQUEST_METHOD'] ) . PHP_EOL;
			$infos .= 'Request URI: '	. General::sanitize( $_SERVER['REQUEST_URI'] ) . PHP_EOL;
			$infos .= 'Request time: '	. General::sanitize( $_SERVER['REQUEST_TIME'] ) . PHP_EOL;
			$infos .= 'CF IP: '			. General::sanitize( $_SERVER['HTTP_CF_CONNECTING_IP'] ) . PHP_EOL;
			$infos .= 'CF Country : '	. General::sanitize( $_SERVER['HTTP_CF_IPCOUNTRY'] ) . PHP_EOL;
			
			return $infos;
		}

	}
