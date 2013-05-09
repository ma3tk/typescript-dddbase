module.exports = (grunt) ->
    grunt.initConfig
        pkg: grunt.file.readJSON 'package.json'
        typescript:
            compile:
                src: ['src/**/*.ts']
                dest: 'compiled'
                # src: ['src/index.ts']
                # dest: 'compiled/src/index.ts'
                options:
                    module: 'commonjs'
                    target: 'es5'
                    # sourcemap: true
                    # declaration: true
            test:
                src: ['test/**/*.ts']
                dest: 'compiled'
                options:
                    module: 'commonjs'
                    target: 'es5'

        clean:
            type:
                src: ['compiled/**/*.js', 'compiled/*']
            build:
                src: ['build/**/*.js']

        concat:
            dist:
                src: ['compiled/src/**/*.js']
                dest: 'build/dddbase.js'
            options:
                separator: ';'

        uglify:
            min:
                files:
                    'build/dddbase.min.js': ['build/dddbase.js']
            ###
            options:
                mangle:
                    expect: ['jQuery']
                sourceMap: 'build/source-map.js'
            ###

        connect:
            preview:
                options:
                    port: 9000
                    base: 'public'

        regarde:
            src:
                files: ['src/**/*.*']
                tasks: ['generate']

    grunt.loadNpmTasks 'grunt-typescript'
    grunt.loadNpmTasks 'grunt-contrib-clean'
    grunt.loadNpmTasks 'grunt-contrib-concat'
    grunt.loadNpmTasks 'grunt-contrib-uglify'
    grunt.loadNpmTasks 'grunt-contrib-copy'
    grunt.loadNpmTasks 'grunt-contrib-connect'
    grunt.loadNpmTasks 'grunt-regarde'

    grunt.registerTask 'compile', ['typescript']
    grunt.registerTask 'type', ['typescript']
    grunt.registerTask 'default', ['type']
    grunt.registerTask 'build', ['typescript:compile', 'concat', 'uglify']

