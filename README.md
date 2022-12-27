# neeto-course-src

This repository contains the format in which the course data should be stored, if you choose to keep the source of your neetoCourse courses as a github repository.

You can fork this repository and use it as a template for your own courses.

## Format

### 1. `assets` directory ###
This directory contains the unique assets for the courses. It contains the following sub-directories:

- `images`: This contains all the images used in the course. The images can be used in the markdown files in `pages` and also in `metadata.yml` in courses as home logos and logos.

- `databases`: This contains the `.db` files used in the course pages when an editor makes use of `sql` and needs a database as a base for running/testing queries.


### 2. `courses` directory ###
This directory contains the courses data.
Each course should be stored in a separate directory inside `courses`, with a preferrably slugified name/reference to a course, but there is no restriction.

For example, the template repository here contains five courses, referenced by `learn-ruby`, `learn-javascript` and so on.

Each course directory should contain the following contents:

#### 2.1. `assets.yml` file ####
This file should contain the assets used in the course. It is a YAML file with the following structure:

```yaml
---
images:
- learn-sql.svg
- sql-header-image.png
- sql_sum.png
databases:
- students1.db
- students2-v1.db
- students3-v1.db
- students3-v3.db
- students3-v2.db
```

All images that we want to use in the course should be listed in the `images` array. Similarly, all databases that we want to use in the course should be listed in the `databases` array.
If you want to use an image or database in the course, it should also be present in the `assets` directory in the repository root.

#### 2.2. `metadata.yml` file ####
This file should contain the metadata/properties of the course. It is a YAML file with the following structure:

```yaml
---
name: Learn HTML
subheading: Learn HTML by actually writing HTML
slug: learn-html
published: false
home_logo: javascript.svg
logo: html-header-image.png
custom_data:
  key: html
```

Here are the validations on these fields:

- *name*: *(required)* *(string)* The name of the course
- *subheading*: *(optional)* *(string)* The subheading/description of the course
- *slug*: *(required)* *(string)* The slug of the course. This is used to generate the URL of the course. This should be unique for each course.
- *published*: *(required)* *(string)* A boolean (*true/false*) value indicating whether the course is published or not.
- *home_logo*: *(optional)* *(string)* The name of the logo file to be used on the home page. A file with the same name should be present in the `assets/images` directory, if specified.
- *logo*: *(optional)* *(string)* The name of the logo file to be used on the course page. A file with the same name should be present in the `assets/images` directory, if specified.
- *custom_data*: *(optional)* *(object)* A custom object containing any custom data that you want to store for the course. This can be used to store any custom data that you want to use in your application.

#### 2.3. `chapters.yml` file ####
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

#### 2.4. `chapters` directory ####
This directory inside each course directory contains the chapters data.
Each chapter should be stored in a separate directory inside `chapters`, with the name starting with a number followed by a hyphen and then the slug of the chapter.
Additionally, the names of chapter directories should be in the same order as they would be in `chapters.yml`. For example, if you have 2 chapters with slugs `getting-started`and `convert-string-into-array` in that order, then a valid naming scheme for the chapter directories can be  `1-getting-started` and `2-convert-string-into-array`.

Each chapter directory should contain the following files:

##### 2.4.1. `pages.yml` #####
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

##### 2.4.2. `pages` directory #####
This directory inside each chapter directory contains the pages data.

Each page should be stored in a separate markdown (`.md`) file inside `pages`, with the file name starting with a number followed by a hyphen and then the slug of the page.

Additionally, the names of page files should be in the same order as they would be in `pages.yml`. For example, if you have 2 pages with slugs `convert-a-string-into-an-array` and `exercise-string-to-array` in that order, then a valid naming scheme for the page files can be  `1-convert-a-string-into-an-array` and `2-exercise-string-to-array`.

Each markdown file in `pages` should contain just the content of the page in markdown fashion.

## Commit hook validations

To make sure the data is valid, we have a commit hook that runs validations on the data on each commit made to the repository. If the data is not valid, the hook will fail.

To set up the hook, run the following commands in the root of the repository:

```sh
bundle install
yarn install
```

After this, the hook will be set up and will run on each commit. The error messages, if a validation fails are quite verbose and should be self-explanatory. They are mostly related to the validations mentioned in the Format section.
