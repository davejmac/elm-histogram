/* eslint-disable no-restricted-syntax, no-var, guard-for-in, prefer-template, object-shorthand, vars-on-top, max-len, prefer-arrow-callback, func-names */
var gulp = require('gulp');
var sass = require('gulp-sass');
var plumber = require('gulp-plumber');
var notify = require('gulp-notify');
var gutil = require('gulp-util');
var elm  = require('gulp-elm');
var gls = require('gulp-live-server');


gulp.task('default', ['sass', 'serve', 'elm-bundle'], function () {
    gutil.log('Running Gulp');
});

//
// Elm
//
gulp.task('elm-init', elm.init);

gulp.task('elm', ['elm-init'], function(){
  return gulp.src('src/elm/*.elm')
    .pipe(elm())
    .pipe(gulp.dest('dist/'));
});

gulp.task('elm-bundle', ['elm-init'], function(){
  return gulp.src('src/elm/*.elm')
    .pipe(elm.bundle('elm.js'))
    .pipe(gulp.dest('dist/js/'));
});

//
// Sass
//
gulp.task('sass', function () {
    gulp.src(['./src/sass/*.scss'])
        .pipe(plumber({
            errorHandler: notify.onError({
                title: 'SASS Error',
                message: function (error) {
                    process.stdout.write('\x07');
                    gutil.log('[SASS]', error);
                    return error.message + ' on line ' + error.lineNumber + ' in ' + error.fileName.split('/').slice(-1);
                }
            })
        }))
        .pipe(sass())
        .pipe(gulp.dest('./dist/css'))
});

// Watch
gulp.task('serve', ['sass', 'elm-bundle'], function (gulpCallback) {
    gulp.watch(['./src/sass/**/*.scss', './src/sass/*.scss'], ['sass']);
    gulp.watch(['./src/elm/**/*.elm', './src/elm/*.scss'], ['elm-bundle']);

    var server = gls.static('.', 3000);
    server.start();
    gulpCallback();
});
