// Generated by CoffeeScript 1.8.0
(function() {
  var assetsLocation;

  assetsLocation = 'public/.assets';

  module.exports = function(grunt) {
    grunt.initConfig({
      cfg: {
        coffeeFiles: [assetsLocation + '/coffee/app.coffee']
      },
      imagemin: {
        dist: {
          options: {
            optimizationLevel: 3
          },
          files: [
            {
              expand: true,
              cwd: assetsLocation + '/images',
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
              cwd: assetsLocation + '/images',
              src: ['**/*.{png,jpg,gif}'],
              dest: 'public/img'
            }
          ]
        }
      },
      clean: {
        dev: ['public/temp/**/*', 'public/css/*', 'public/js/*'],
        dist: ['public/temp/**/*', 'public/img/*', 'public/css/*', 'public/js/*']
      },
      coffee: {
        dev: {
          options: {
            bare: false,
            sourceMap: true
          },
          files: {
            'public/js/application.js': '<%= cfg.coffeeFiles %>'
          }
        },
        dist: {
          options: {
            bare: false,
            sourceMap: true
          },
          files: {
            'public/temp/js/application.js': '<%= cfg.coffeeFiles %>'
          }
        }
      },
      compass: {
        dev: {
          options: {
            sourcemap: true,
            sassDir: assetsLocation + '/scss',
            cssDir: 'public/css',
            environment: 'development',
            outputStyle: 'compact',
            watch: true
          }
        },
        dist: {
          options: {
            sourcemap: true,
            sassDir: assetsLocation + '/scss',
            cssDir: 'public/temp/css',
            environment: 'development',
            outputStyle: 'compact'
          }
        }
      },
      copy: {
        build: {
          files: [
            {
              expand: true,
              cwd: 'public/.assets/js',
              src: ['*.js'],
              dest: 'public/temp/js'
            }
          ]
        }
      },
      uglify: {
        build: {
          options: {
            mangle: true,
            sourceMap: true,
            compress: {
              drop_console: true
            }
          },
          files: [
            {
              expand: true,
              cwd: 'public/temp/js',
              src: ['*.js', '!*.min.js'],
              dest: 'public/js'
            }
          ]
        }
      },
      cssmin: {
        build: {
          options: {
            sourceMap: true,
            advanced: false,
            compatibility: true,
            processImport: false,
            shorthandCompacting: false
          },
          files: [
            {
              expand: true,
              cwd: 'public/temp/css',
              src: ['*.css', '!*.min.css'],
              dest: 'public/css'
            }
          ]
        }
      },
      watch: {
        scripts: {
          files: assetsLocation + '/coffee/*.coffee',
          tasks: ['coffee:dev']
        },
        configFiles: {
          files: 'Gruntfile.js',
          options: {
            reload: true
          }
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
    grunt.registerTask('build', ['clean:dev', 'imagemin:dev', 'coffee:dev', 'compass:dev', 'watch']);
    return grunt.registerTask('deploy', ['clean:all', 'imagemin:dist', 'coffee:dist', 'compass:dist', 'copy:build', 'uglify:build', 'cssmin:build']);
  };

}).call(this);

//# sourceMappingURL=Gruntfile.js.map
