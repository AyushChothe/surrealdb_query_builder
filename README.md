# Surrealdb Query Builder

[![pub package](https://img.shields.io/pub/v/surrealdb_query_builder.svg?label=surrealdb_query_builder&color=blue)](https://pub.dartlang.org/packages/surrealdb_query_builder)
[![ci](https://github.com/AyushChothe/surrealdb_query_builder/actions/workflows/main.yaml/badge.svg?branch=main)](https://github.com/AyushChothe/surrealdb_query_builder/actions/workflows/main.yaml)
[![style: very good analysis][very_good_analysis_badge]][very_good_analysis_link]
[![License: MIT][license_badge]][license_link]

A SurrealDB Query Builder written in Pure Dart.

## Installation 💻

**❗ In order to start using Surrealdb Query Builder you must have the [Dart SDK][dart_install_link] installed on your machine.**

Add `surrealdb_query_builder` to your `pubspec.yaml`:

```yaml
dependencies:
  surrealdb_query_builder:
```

Install it:

```sh
dart pub get
```

---

## Features ✨

- [x] `SELECT` Statement
- [x] `LIVE SELECT` Statement
- [x] `CREATE` Statement
- [x] `USE` Statement
- [ ] `INSERT` Statement
- [ ] `UPDATE` Statement
- [ ] `DELETE` Statement
- [ ] `RELATE` Statement
- [ ] `REMOVE` Statement

### Maybe
- [ ] `DEFINE` Statement


## Examples
```dart

  expect(
    SurrealdbQueryBuilder.select(thing: 'person').build(),
    equals('SELECT * FROM person;'),
  ); 

  expect(
    SurrealdbQueryBuilder.select(thing: 'person')
      .where()
      .eq(field: 'name', value: 'Ayush')
      .and()
      .eq(field: 'age', value: '23')
      .next()
      .build(),
    equals('SELECT * FROM person WHERE name = Ayush AND age = 23;'),
  );

  expect(
    SurrealdbQueryBuilder.select(
      thing: 'person',
      omitfields: ['fullname'],
      fields: ['name', 'age'],
    )
      .withIndex(indexes: ['unique_name'])
      .where()
      .eq(field: 'name', value: 'ayush')
      .or()
      .eq(field: 'name', value: 'ash')
      .and()
      .neq(field: 'age', value: '0')
      .next()
      .orderBy(orderBys: [
        OrderBy(field: 'age', order: Order.desc, type: OrderType.numeric)
      ])
      .limit(limit: '5')
      .start(start: '0')
      .fetch(fields: ['projects'])
      .timeout(duration: '5s')
      .parallel()
      .build(),
    equals(
      'SELECT name, age OMIT fullname FROM person WITH INDEX unique_name '
      'WHERE name = ayush OR name = ash AND age != 0 '
      'ORDER age NUMERIC DESC LIMIT 5 START 0 '
      'FETCH projects TIMEOUT 5s PARALLEL;'),
  );
```
## Continuous Integration 🤖

Surrealdb Query Builder comes with a built-in [GitHub Actions workflow][github_actions_link] powered by [Very Good Workflows][very_good_workflows_link] but you can also add your preferred CI/CD solution.

Out of the box, on each pull request and push, the CI `formats`, `lints`, and `tests` the code. This ensures the code remains consistent and behaves correctly as you add functionality or make changes. The project uses [Very Good Analysis][very_good_analysis_link] for a strict set of analysis options used by our team. Code coverage is enforced using the [Very Good Workflows][very_good_coverage_link].

---

## Running Tests 🧪

To run all unit tests:

```sh
dart pub global activate coverage
dart pub global run coverage:test_with_coverage
dart pub global run coverage:format_coverage --lcov --in=coverage --out=coverage/lcov.info -b .
```

To view the generated coverage report you can use [lcov](https://github.com/linux-test-project/lcov).

```sh
# Generate Coverage Report
genhtml coverage/lcov.info -o coverage/

# Open Coverage Report
open coverage/index.html
```

[dart_install_link]: https://dart.dev/get-dart
[github_actions_link]: https://docs.github.com/en/actions/learn-github-actions
[license_badge]: https://img.shields.io/badge/license-MIT-blue.svg
[license_link]: https://opensource.org/licenses/MIT
[logo_black]: https://raw.githubusercontent.com/VGVentures/very_good_brand/main/styles/README/vgv_logo_black.png#gh-light-mode-only
[logo_white]: https://raw.githubusercontent.com/VGVentures/very_good_brand/main/styles/README/vgv_logo_white.png#gh-dark-mode-only
[mason_link]: https://github.com/felangel/mason
[very_good_analysis_badge]: https://img.shields.io/badge/style-very_good_analysis-B22C89.svg
[very_good_analysis_link]: https://pub.dev/packages/very_good_analysis
[very_good_coverage_link]: https://github.com/marketplace/actions/very-good-coverage
[very_good_ventures_link]: https://verygood.ventures
[very_good_ventures_link_light]: https://verygood.ventures#gh-light-mode-only
[very_good_ventures_link_dark]: https://verygood.ventures#gh-dark-mode-only
[very_good_workflows_link]: https://github.com/VeryGoodOpenSource/very_good_workflows


## Contributors 💪
![contributors](https://contrib.rocks/image?repo=AyushChothe/surrealdb_query_builder)

Made with [contrib.rocks](https://contrib.rocks).