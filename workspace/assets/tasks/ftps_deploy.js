'use strict';

module.exports = function ftps_deploy(grunt) {
	var stripJsonComments = require('strip-json-comments');
	
	var FTP_FILE = JSON.parse(stripJsonComments(grunt.file.read('../../ftpsync.settings')));
	if (!/\/$/.test(FTP_FILE.default.path)) {
		FTP_FILE.default.path += '/';
	}
	var FTP_PASS = '.ftppass';
	
	grunt.gruntLoad('ftps-deploy');
	grunt.config.merge({
		ftps_deploy: {
			options: {
				auth: {
					host: FTP_FILE.default.host,
					port: FTP_FILE.default.port || 21,
					authKey: 'default',
					secure: true
				}
			},
			build: {
				files: [{
					cwd: '.',
					src: [
						'js/<%= pkg.name %>.min.js',
						'css/<%= pkg.name %>.min.css',
						'<%= src.buildfile %>',
						'<%= src.pkgfile %>'
					],
					dest: FTP_FILE.default.path + 'workspace/assets/'
				}]
			},
			bundle: {
				files: [{
					cwd: '.',
					src: [
						'css/lib/bundle.css',
						'css/lib/bundle.less',
						'css/core/bundle.less'
					],
					dest: FTP_FILE.default.path + 'workspace/assets/'
				}]
			}
		}
	});

	// ftps boot
	grunt.registerTask('ftps_boot', 'Creates FTP files', function () {
		grunt.file.write(FTP_PASS, JSON.stringify(FTP_FILE));
	});

	// ftps clean up
	grunt.registerTask('ftps_cleanup', 'Cleans shit up', function () {
		grunt.file.delete(FTP_PASS);
	});

	// push
	grunt.registerTask('push', ['ftps_boot', 'ftps_deploy:build', 'ftps_cleanup']);
};
