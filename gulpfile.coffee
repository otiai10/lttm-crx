gulp        = require 'gulp'
coffee      = require 'gulp-coffee'
sass        = require('gulp-sass')(require('sass'))
clean       = require 'gulp-clean'
zip         = require 'gulp-zip'

paths =
  lib: 'lib/**/*.*'
  js:  'src/js/**/*.coffee'
  css: 'src/css/**/*.scss'

gulp.task 'copy', ->
  gulp.src(paths.lib)
    .pipe(gulp.dest('build/'))

gulp.task 'coffee', ->
  gulp.src(paths.js)
    .pipe(coffee())
    .pipe(gulp.dest('build/js/'))

gulp.task 'sass', ->
  gulp.src(paths.css)
    .pipe(sass())
    .pipe(gulp.dest('build/css/'))

gulp.task 'watch', ->
  gulp.watch paths.lib, gulp.series('copy')
  gulp.watch paths.js,  gulp.series('coffee')
  gulp.watch paths.css, gulp.series('sass')

gulp.task 'clean', ->
  gulp.src(['build', 'build.zip'], { read: false, allowEmpty: true })
    .pipe(clean())

gulp.task 'zip', ->
  gulp.src('build/**/*.*')
    .pipe(zip('build.zip'))
    .pipe(gulp.dest('./'))

gulp.task 'build', gulp.parallel('copy', 'coffee', 'sass')
gulp.task 'rebuild', gulp.series('clean', 'build')
gulp.task 'release', gulp.series('clean', 'build', 'zip')
gulp.task 'default', gulp.series('clean', 'build', 'watch')
