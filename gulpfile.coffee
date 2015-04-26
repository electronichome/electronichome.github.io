# Gulp File

gulp = require('gulp')
gutil = require('gulp-util')
coffee = require('gulp-coffee')
jade = require 'gulp-jade'
ghPages = require('gulp-gh-pages')
browser = require('browser-sync')
gss = require('gulp-gss')
concat = require('gulp-concat')


gulp.task 'deploy', ->
  gulp.src('./dist/**/*')
    .pipe ghPages(
      branch: 'master'
    )

gulp.task 'build', ->
  gulp.src('./src/gss/**/*.gss').pipe(gss()).pipe(concat('gss.json')).pipe gulp.dest('./dist/gss')
  gulp.src('./src/**/*.html').pipe gulp.dest('./dist')

  gulp.src './src/**/*.jade'
    .pipe jade pretty: true, locals: { web: true }
    .pipe gulp.dest './dist'

  gulp.src('./src/**/*.coffee')
    .pipe coffee bare: true
      .on 'error', gutil.log
    .pipe gulp.dest('./dist')