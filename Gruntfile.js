//@ sourceMappingURL=Gruntfile.map
module.exports = function(grunt) {
  grunt.initConfig({
    cfg: {
      coffeeFiles: ['assets/coffee/app.coffee'],
      gruntFiles: ['assets/coffee/grunt.coffee']
    },
    imagemin: {
      dist: {
        options: {
          optimizationLevel: 3
        },
        files: [
          {
            expand: true,
            cwd: 'assets/images',
            src: ['**/*.{png,jpg,gif}'],
            dest: 'public/img'
          }
        ]
      },
      dev: {
        options: {
          optimizationLevel: 1
        },
        files: [
          {
            expand: true,
            cwd: 'assets/images',
            src: ['**/*.{png,jpg,gif}'],
            dest: 'public/img'
          }
        ]
      }
    },
    clean: {
      all: ['.tmp/**/*', 'public/img/*', 'public/css/*', 'public/js/*', '.sass-cache/**/*']
    },
    coffee: {
      options: {
        bare: true,
        sourceMap: true
      },
      build: {
        files: {
          '.tmp/js/application.js': '<%= cfg.coffeeFiles %>',
          'Gruntfile.js': '<%= cfg.gruntFiles %>'
        }
      }
    },
    compass: {
      dist: {
        options: {
          sassDir: 'assets/scss',
          cssDir: '.tmp/css',
          environment: 'production',
          outputStyle: 'compressed'
        }
      },
      dev: {
        options: {
          sassDir: 'assets/scss',
          cssDir: '.tmp/css',
          environment: 'development',
          outputStyle: 'compact'
        }
      }
    },
    copy: {
      assets: {
        files: [
          {
            expand: true,
            cwd: 'assets/js',
            src: ['**'],
            dest: 'public/js'
          }
        ]
      }
    },
    uglify: {
      build: {
        options: {
          mangle: true,
          compress: true,
          sourceMap: true
        },
        files: [
          {
            expand: true,
            cwd: '.tmp/js',
            src: ['*.js', '!*.min.js'],
            dest: 'public/js',
            ext: '.min.js'
          }
        ]
      }
    },
    cssmin: {
      build: {
        files: [
          {
            expand: true,
            cwd: '.tmp/css',
            src: ['*.css', '!*.min.css'],
            dest: 'public/css',
            ext: '.min.css'
          }
        ]
      }
    },
    watch: {
      scripts: {
        files: 'assets/coffee/*.coffee',
        tasks: ['coffee']
      },
      assets: {
        files: 'assets/images/*',
        tasks: ['imagemin:dev']
      },
      configFiles: {
        files: 'Gruntfile.js',
        options: {
          reload: true
        }
      },
      scss: {
        files: 'assets/scss/*.scss',
        tasks: ['compass:dev']
      },
      css: {
        files: '.tmp/css/*.css',
        tasks: ['cssmin:build']
      },
      js: {
        files: '.tmp/js/*.js',
        tasks: ['uglify:build']
      }
    }
  });
  grunt.loadNpmTasks('grunt-contrib-clean');
  grunt.loadNpmTasks('grunt-contrib-coffee');
  grunt.loadNpmTasks('grunt-contrib-compass');
  grunt.loadNpmTasks('grunt-contrib-copy');
  grunt.loadNpmTasks('grunt-contrib-cssmin');
  grunt.loadNpmTasks('grunt-contrib-imagemin');
  grunt.loadNpmTasks('grunt-contrib-uglify');
  grunt.loadNpmTasks('grunt-contrib-watch');
  grunt.registerTask('build', ['clean:all', 'imagemin:dev', 'coffee', 'uglify:build', 'compass:dev', 'cssmin:build', 'watch']);
  return grunt.registerTask('deploy', ['clean:all', 'imagemin:dist', 'coffee', 'uglify:build', 'compass:dist', 'cssmin:build']);
};
