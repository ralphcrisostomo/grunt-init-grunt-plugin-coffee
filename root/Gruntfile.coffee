###
 * {%= name %}
 * {%= homepage %}
 *
 * Copyright (c) {%= grunt.template.today('yyyy') %} {%= author_name %}
 * Licensed under the {%= licenses.join(', ') %} license{%= licenses.length === 1 ? '' : 's' %}.
###
  
'use strict'

module.exports = (grunt) ->

  # Project configuration.
  grunt.initConfig
    coffee_jshint:
      all: [
        'Gruntfile.coffee'
        'tasks/*.coffee'
        '<%= nodeunit.tests %>'
      ],
      options:
        jshintrc: '.jshintrc'
        globals: [
          'module'
          'require'
          'exports'
        ]

    # Before generating any new files, remove any previously-created files.
    clean: 
      tests: ['tmp']

    # Configuration to be run (and then tested).
    {%= short_name %}: 
      default_options: 
        options: {} 
        
        files: 
          'tmp/default_options': ['test/fixtures/testing', 'test/fixtures/123']
      custom_options: 
        options: 
          separator: ': '
          punctuation: ' !!!'
        files:
          'tmp/custom_options': ['test/fixtures/testing', 'test/fixtures/123']

    # Unit tests.
    nodeunit: 
      tests: ['test/*_test.coffee']

  # Actually load this plugin's task(s).
  grunt.loadTasks('tasks') 

  # These plugins provide necessary tasks.
  grunt.loadNpmTasks('grunt-coffee-jshint')
  grunt.loadNpmTasks('grunt-contrib-clean') 
  grunt.loadNpmTasks('grunt-contrib-nodeunit') 

  # Whenever the "test" task is run, first clean the "tmp" dir, then run this
  # plugin's task(s), then test the result.
  grunt.registerTask('test', ['clean', '{%= short_name %}', 'nodeunit']) 

  # By default, lint and run all tests.
  grunt.registerTask('default', ['coffee_jshint', 'test'])

