module.exports = (grunt)->

  ############################################################
  # Project configuration
  ############################################################

  grunt.initConfig

    cfg:
      coffeeFiles: [
        'assets/coffee/app.coffee' # first app js
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

    compass:
      dist:
        options:
          sourceMap: true
          sassDir: 'assets/scss'
          cssDir: '.tmp/css'
          imagesDir: 'public/img'
          javascriptsDir: 'public/js'
          environment: 'production'
          outputStyle: 'compressed'
          watch: true
          clean: true
      dev:
        options:
          sourceMap: true
          sassDir: 'assets/scss'
          cssDir: '.tmp/css'
          imagesDir: 'public/img'
          javascriptsDir: 'public/js'
          environment: 'development'
          outputStyle: 'compact'
          watch: true
          clean: true

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
        files: [
          expand: true,
          cwd: 'assets/js',
          src: '**/*.js',
          dest: 'public/js'
        ]

    cssmin:
      build:
        files: [
          expand: true,
          cwd: '.tmp/css',
          src: ['*.css', '!*.min.css'],
          dest: 'public/css',
          ext: '.min.css'
        ]

    watch:
      scripts:
        files: 'public/**/*.coffee'
        tasks: ['coffee']
      assets:
        files: 'assets/images/*'
        tasks: ['imagemin:dev']

  # concat:
  #   build:
  #     files: [
  #       # {
  #       #   dest: '.tmp/concat/js/application.js'
  #       #   src: ['<%= cfg.coffeeFiles %>']
  #       # }
  #       {
  #         dest: '.tmp/concat/css/application.css'
  #         src: ['.tmp/stylus/index.css']
  #       }
  #     ]

  # concat:
  #   vendor:
  #     options:
  #       separator: ';\n'
  #     src: ['app/**/*.js', '!app/assets/**/*.js', '!app/assets/test/**']
  #     dest: '<%= cfg.tmp %>/vendor.js'
  #   css:
  #     options:
  #       separator: '\n\n'
  #     src: ['app/**/*.css']
  #     dest: '<%= cfg.tmp %>/vendor.css'

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
  grunt.loadNpmTasks('grunt-connect-watch')

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
  ])

  grunt.registerTask('deploy', [
    'clean:all' # public and tmp
    'imagemin:dist' # public
    'coffee' # tmp
    'uglify:build' # public
    'compass:dist' # tmp
    'cssmin:build' # public
  ])
