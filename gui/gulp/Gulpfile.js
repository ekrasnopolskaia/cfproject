var gulp = require('gulp'),
    concat = require('gulp-concat'),
    run = require('gulp-run'),
    sass = require('gulp-sass'),
    postcss = require('gulp-postcss'),
    autoprefixer = require('autoprefixer'),
    uglify = require('gulp-uglify'),
    rename = require('gulp-rename'),
    babel = require('gulp-babel'),
    rjs = require('gulp-requirejs'),
    configs = require('./config.json');

/*** ---------------------------------------------------CSS Tasks---*/
gulp.task('cssDebug', function () {
    //run('cd ..\\..\\pub\\styles && ATTRIB -R styles.css').exec();
    return gulp.src('./../scss/styles.scss')
        .pipe(sass({outputStyle: 'nested'}))
        .pipe(postcss([autoprefixer({browsers: configs.supportedBrowsers})]))
        .pipe(gulp.dest('./../../pub/css'));
});
gulp.task('css', ['cssDebug'], function () {
    // run('cd ..\\..\\pub\\styles && ATTRIB -R styles.min.css').exec();
    return gulp.src('./../scss/styles.scss')
        .pipe(sass({outputStyle: 'compressed'}))
        .pipe(postcss([autoprefixer({browsers: configs.supportedBrowsers})]))
        .pipe(rename('styles.min.css'))
        .pipe(gulp.dest('./../css/styles'));
});

/*** ---------------------------------------------------getApp Tasks---*/
gulp.task('appDebug', function () {
    //run('cd ..\\..\\pub\\scripts && ATTRIB -R app.js').exec();
    return gulp.src(configs.js)
        .pipe(babel({presets: [['env',{modules:false}]]}))
        .pipe(concat({path: 'app.js', stat: {mode: 0666}}))
        .pipe(gulp.dest('./../../pub/js'));
});

gulp.task('rjs', function (){
    return rjs({baseUrl:'./../js/app.js',out: './../js/bootstrap.js'}).pipe(gulp.dest('./../js/'));
});

gulp.task('app', ['appDebug'], function () {
    // run('cd ..\\..\\pub\\scripts && ATTRIB -R app.min.js').exec();
    return gulp.src(configs.js)
        .pipe(uglify())
        .pipe(concat({path: 'app.min.js', stat: {mode: 0666}}))
        .pipe(gulp.dest('./../js'));
});


gulp.task('watch', function () {
    gulp.watch(configs.js, ['appDebug']);
    gulp.watch('./../scss/**/*.scss', ['cssDebug'])
});