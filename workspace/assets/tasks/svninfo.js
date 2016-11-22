'use strict';

module.exports = function svninfo(grunt) {
	grunt.gruntLoad(grunt.task.current.name);
	grunt.config.merge({
		svninfo: {
			options: {
				cwd: '../../'
			}
		}
	});
};
