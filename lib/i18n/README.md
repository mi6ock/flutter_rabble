- コマンドで自動生成

```bash

flutter pub pub run intl_translation:extract_to_arb --output-dir=lib/i18n/i18n lib/i18n/i18n/Strings.dart
flutter pub pub run intl_translation:generate_from_arb --output-dir=lib/i18n/i18n --no-use-deferred-loading lib/i18n/i18n/Strings.dart lib/i18n/i18n/intl_messages.arb lib/i18n/i18n/intl_ja.arb

```

- ios/Runner/info.plistに追加

```bash

<key>CFBundleLocalizations</key>
<array>
    <string>en</string>
    <string>ja</string>
</array>

```