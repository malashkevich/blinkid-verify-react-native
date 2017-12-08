## Transition to 1.1.1

- No changes

## Transition to 1.1.0

- `PPBlinkOcrRecognizerResult` and `PPBlinkOcrRecognizerSettings` are now deprecated. Use `PPDetectorRecognizerResult` and `PPDetectorRecognizerSettings` for templating or `PPBlinkInputRecognizerResult` and `PPBlinkInputRecognizerSettings` for segment scan
- `PPSerbianPdf417RecognizerResult` and `PPSerbianPdf417RecognizerSettings` are renamed to `PPSerbianBarcodeRecognizerResult` and `PPSerbianBarcodeRecognizerSettings`
- There is no more option in PPUsdlRecognizerSettings to scan 1D barcodes. Previously this setting did nothing - it's OK to just delete the setter call if you use it.