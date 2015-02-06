module.exports = (grunt)->

  ############################################################
  # Project configuration
  ############################################################

  grunt.initConfig

    cfg:
      coffeeFiles: [
        'assets/coffee/app.coffee' # first app js
      ]
      gruntFiles:[
        'assets/coffee/grunt.coffee' #gruntfile
      ]

    imagemin:
      dist:
        options:
          optimizationLevel: 3
        files: [
          expand: true
          cwd: 'assets/images'
          src: ['**/*.{png,jpg,gif}']
          dest: 'public/img'
        ]
      dev:
        options:
          optimizationLevel: 1
        files: [
          expand: true
          cwd: 'assets/images'
          src: ['**/*.{png,jpg,gif}']
          dest: 'public/img'
        ]


    clean:
      all:[
        '.tmp/**/*'
        'public/img/*'
        'public/css/*'
        'public/js/*'
      ]

    coffee:
      options:
        bare: true
        sourceMap: true
      build:
        files:
          '.tmp/js/application.js': '<%= cfg.coffeeFiles %>'
          'Gruntfile.js': '<%= cfg.gruntFiles %>'

    compass:
      dist:
        options:
          sassDir: 'assets/scss'
          cssDir: '.tmp/css'
          environment: 'production'
          outputStyle: 'compressed'
      dev:
        options:
          sassDir: 'assets/scss'
          cssDir: '.tmp/css'
          environment: 'development'
          outputStyle: 'compact'

    copy:
      assets:
        files: [
          expand: true
          cwd: 'assets/js'
          src: ['**']
          dest: 'public/js'
        ]

    uglify:
      build:
        options:
          mangle: true
          compress: true
          sourceMap: true
        files: [
          expand: true
          cwd: '.tmp/js'
          src: ['*.js', '!*.min.js']
          dest: 'public/js'
          ext: '.min.js'
        ]

    cssmin:
      build:
        files: [
          expand: true
          cwd: '.tmp/css'
          src: ['*.css', '!*.min.css']
          dest: 'public/css'
          ext: '.min.css'
        ]

  ##############################################################
  # Watch Task
  ###############################################################

    watch:
      scripts:
        files: 'assets/coffee/*.coffee'
        tasks: ['coffee']
      assets:
        files: 'assets/images/*'
        tasks: ['imagemin:dev']
      configFiles:
        files: 'Gruntfile.js'
        options:
          reload: true
      scss:
        files: 'assets/scss/*.scss'
        tasks: ['compass:dev']
      css:
        files: '.tmp/css/*.css'
        tasks: ['cssmin:build']
      js:
        files: '.tmp/js/*.js'
        tasks: ['uglify:build']

  ##############################################################
  # Dependencies
  ###############################################################

  grunt.loadNpmTasks('grunt-contrib-clean')
  grunt.loadNpmTasks('grunt-contrib-coffee')
  grunt.loadNpmTasks('grunt-contrib-compass')
  grunt.loadNpmTasks('grunt-contrib-copy')
  grunt.loadNpmTasks('grunt-contrib-cssmin')
  grunt.loadNpmTasks('grunt-contrib-imagemin')
  grunt.loadNpmTasks('grunt-contrib-uglify')
  grunt.loadNpmTasks('grunt-contrib-watch')

  ############################################################
  # Alias tasks
  ############################################################

  grunt.registerTask('build', [
    'clean:all' # public and tmp
    'imagemin:dev' # public
    'coffee' # tmp
    'uglify:build' # public
    'compass:dev' # tmp
    'cssmin:build' # public
    'watch'
  ])

  grunt.registerTask('deploy', [
    'clean:all' # public and tmp
    'imagemin:dist' # public
    'coffee' # tmp
    'uglify:build' # public
    'compass:dist' # tmp
    'cssmin:build' # public
  ])
