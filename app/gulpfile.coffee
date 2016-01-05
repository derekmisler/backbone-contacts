###eslint-env node ###

gulp = require 'gulp'
sass = require 'gulp-sass'
autoprefixer = require 'gulp-autoprefixer'
browserSync = require('browser-sync').create()
coffee = require 'gulp-coffee'
coffeelint = require 'gulp-coffeelint'
browserify = require 'browserify'
imagemin = require 'gulp-imagemin'
pngquant = require 'imagemin-pngquant'
slim = require 'gulp-slim'

gulp.task 'serve', [
  'slim'
  'copy-images'
  'scripts-dist'
  'move-js'
  'styles'
], ->
  gulp.watch 'stylesheets/**/*.scss', [ 'styles' ]
  gulp.watch '*.slim', [ 'slim' ]
  gulp.watch 'js/*.coffee', [ 'scripts-dist' ]
  gulp.watch 'js/*.js', [ 'move-js' ]
  gulp.watch('./dist/**/*').on 'change', browserSync.reload
  browserSync.init server: './dist'
  return

# regular build task if I don't want to watch anything
gulp.task 'build', [
  'slim'
  'copy-images'
  'styles'
  'scripts-dist'
]

# Convert coffee to js, but don't minify or concat, just move to dist
gulp.task 'scripts-dist', ->
  gulp.src('js/**/*.coffee')
    .pipe(coffee())
    .pipe gulp.dest('dist/js')
gulp.task 'move-js', ->
  gulp.src('js/**/*.js')
    .pipe gulp.dest('dist/js')

# lint coffeescript
gulp.task 'lint', ->
  gulp.src([
    '**/*.coffee'
    '!node_modules/**'
  ])
    .pipe(coffeelint())
    .pipe(coffeelint.reporter())

# Convert slim to html and move to dist
gulp.task 'slim', ->
  gulp.src('*.slim')
    .pipe slim pretty: true
    .pipe gulp.dest 'dist'

# Minify pngs and copy images to dist folder
gulp.task 'copy-images', ->
  gulp.src('img/*').pipe(imagemin(
    progressive: true
    use: [ pngquant() ])).pipe gulp.dest('dist/img')

# Create the CSS from Sass, autoprefix and minify
gulp.task 'styles', ->
  gulp.src('stylesheets/main.scss')
    .pipe(sass().on('error', sass.logError))
    .pipe(autoprefixer(browsers: [ 'last 2 versions' ]))
    .pipe(sass(outputStyle: 'compressed'))
    .pipe(gulp.dest('dist/css'))
    .pipe browserSync.stream()
