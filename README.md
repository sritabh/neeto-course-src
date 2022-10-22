# neeto-course-src

This repository contains the format in which the course data should be stored, if you choose to keep the source of your neetoCourse courses as a github repository.

You can fork this repository and use it as a template for your own courses.

## Format

### 1. `courses.yml` ###
This file at the root of the repository contains the list of courses and their data. It is a YAML file with the following structure:

```yaml
- name: Learn Ruby
  subheading: Learn Ruby by actually writing Ruby code
  slug: learn-ruby
  published: true
  home_logo: ruby.svg
  logo: ruby-header-image.png
  custom_data:
    key: ruby
- name: Learn SQL
  subheading: Learn SQL by actually writing SQL code
  slug: learn-sql
  published: true
  home_logo: learn-sql.svg
  logo: sql-header-image.png
  custom_data:
    key: sql
- name: Learn Javascript
  subheading: Learn Javascript by actually writing Javascript code
  slug: learn-javascript
  published: true
  home_logo: javascript.svg
  logo: javascript-header-image.png
  custom_data:
    key: javascript
```

Each course in `courses.yml` contains the following fields:

- *name*: *(required)* *(string)* The name of the course
- *subheading*: *(optional)* *(string)* The subheading/description of the course
- *slug*: *(required)* *(string)* The slug of the course. This is used to generate the URL of the course. This should be unique for each course.
- *published*: *(required)* *(string)* A boolean (*true/false*) value indicating whether the course is published or not.
- *home_logo*: *(optional)* *(string)* The name of the logo file to be used on the home page. A file with the same name should be present in the `assets/images` directory, if specified.
- *logo*: *(optional)* *(string)* The name of the logo file to be used on the course page. A file with the same name should be present in the `assets/images` directory, if specified.
- *custom_data*: *(optional)* *(object)* A custom object containing any custom data that you want to store for the course. This can be used to store any custom data that you want to use in your application.

### 2. `courses` directory ###
This directory contains the courses data. Each course should be stored in a separate directory inside `courses`, with the name starting with a number followed by a hyphen and then the slug of the course. Additionally, the names of course directories should be in the same order as they would be in `courses.yml`. For example, if you have 3 courses with slugs `learn-ruby`, `learn-sql` and `learn-javascript` in that order, then a valid naming scheme for the course directories can be  `1-learn-ruby`, `2-learn-sql` and `3-learn-javascript`.

Each course directory should contain the following files:

#### 2.1. `chapters.yml` ####
This file at the root of each course directory inside `courses`, contains the list of chapters within the course and their data. It is a YAML file with the following structure:

```yaml
- name: Getting started
  slug: getting-started
- name: Convert String into Array
  slug: convert-string-into-array
```

Each chapter in `chapters.yml` contains the following fields:

- *name*: *(required)* *(string)* The name of the chapter
- *slug*: *(required)* *(string)* The slug of the chapter. This is used to generate the URL of the chapter. This should be unique for each chapter within a course.

#### 2.2. `chapters` directory ####
This directory inside each course directory contains the chapters data. Each chapter should be stored in a separate directory inside `chapters`, with the name starting with a number followed by a hyphen and then the slug of the chapter. Additionally, the names of chapter directories should be in the same order as they would be in `chapters.yml`. For example, if you have 2 chapters with slugs `getting-started`and `convert-string-into-array` in that order, then a valid naming scheme for the chapter directories can be  `1-getting-started` and `2-convert-string-into-array`.

Each chapter directory should contain the following files:

##### 2.2.1. `pages.yml` #####
This file at the root of each chapter directory inside `chapters`, contains the list of pages within the chapter and their data. It is a YAML file with the following structure:

```yaml
- title: Convert a String into an Array
  slug: convert-a-string-into-an-array
  page_type: lesson
- title: Exercise - String to array
  slug: exercise-string-to-array
  page_type: exercise
```

Each page in `pages.yml` contains the following fields:

- *title*: *(required)* *(string)* The title of the page
- *slug*: *(required)* *(string)* The slug of the page. This is used to generate the URL of the page. This should be unique for each page within a chapter.
- *page_type*: *(required)* *(string)* The type of page. This can be either `lesson`, `exercise` or `assessment`.

##### 2.2.2. `pages` directory #####
This directory inside each chapter directory contains the pages data. Each page should be stored in a separate markdown (`.md`) file inside `pages`, with the file name starting with a number followed by a hyphen and then the slug of the page. Additionally, the names of page files should be in the same order as they would be in `pages.yml`. For example, if you have 2 pages with slugs `convert-a-string-into-an-array` and `exercise-string-to-array` in that order, then a valid naming scheme for the page files can be  `1-convert-a-string-into-an-array` and `2-exercise-string-to-array`.

Each markdown file in `pages` should contain just the content of the page in markdown fashion.


### 3. `assets` directory ###
This directory contains the assets for the courses. It contains the following sub-directories:

- `images`: This contains all the images used in the course. The images can be used in the markdown files in `pages` and also in `courses.yml` as home logos and logos.
- `databases`: This contains the db files used in the course pages when an editor makes use of `sql` and needs a database as a base for running/testing queries.



