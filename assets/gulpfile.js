var gulp = require('gulp');
var sass = require('gulp-sass');
var sourcemaps = require('gulp-sourcemaps');
var bower = require('main-bower-files');
var autoprefixer = require('gulp-autoprefixer');
var jshint = require('gulp-jshint');
var uglify = require('gulp-uglify');
var rename = require('gulp-rename');

gulp.task('styles', function() {
	
	gulp.src('styles/mky.scss')
		.pipe(sourcemaps.init())
		.pipe(sass({
			outputStyle: 'compressed',
			precision: 14,
		})
		.on('error', sass.logError))
		.pipe(autoprefixer())
		.pipe(sourcemaps.write())
		.pipe(rename('mky.min.css'))
		.pipe(gulp.dest('styles'));
	
});

gulp.task('scripts', function() {
	
	gulp.src('scripts/mky.js')
		.pipe(sourcemaps.init())
		.pipe(jshint('.jshintrc'))
		.pipe(jshint.reporter('default'))
		.pipe(uglify())
		.pipe(sourcemaps.write())
		.pipe(rename('mky.min.js'))
		.pipe(gulp.dest('scripts'));
	
});

gulp.task('watch', function() {
	
	gulp.watch('styles/mky.scss', [
		'styles',
	]);
	
	gulp.watch('scripts/mky.js', [
		'scripts',
	]);
	
});

gulp.task('default', [
	'watch',
]);
