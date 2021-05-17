# AveFontHelpers
A few helpers to make working with Dynamic Type easier


## What?

Using Dynamic Type in iOS sometimes can be verbose and trick when wanting to use custom fonts, designs or sizes. You have to to `UIFontMetrics().scaleFont()` and do everything in the right order. If you want to change  the design of a font or go one point smaller, this gets annoying.

This small library provides a helper struct `Font` that can be turned into a dynamic type font easily.

## Usage

The basis is the `Font` structure that you use to define your fonts using the following parameters:
	
- `size` the size in points
- `maximumSize` **optional** the maximum size of the font
- `style` **optional** the text style this font is based on, used for scaling. If size = 0, the iOS text style point size will be used 
- `weight`: **optional** the weight of the font
-  `design` **optional** the design of the font, for example `.rounded`
- `traits` **optional** traits for the font, e.g. `.italic`
- `scalability` **optional**, `.fixed`, `.scalable` or `.placeholder`.  Fixed and placeholder fonts wont scale dynamically
- `name`: **optional** the name of the font family to use, if nil the system font will be used


You can define fonts like this:
```
extension Font {
	// we want a thinner large title
	let largeTitle = Font(style: .largeTitle, weight: .thin)
	
	// our custom body font, scales as the iOS body font
	let body = Font(size: 14, style: .body)
	
	// our custom button font, with a maximum size
	let button = Font(size: 13, maximumSize: 26, weight: .bold)
	
	// a tab bar font that doesn't scale
	let tabBarItem = Font(size: 11, scalalability: .fixed)
	let tabBarItem2 = Font.fixed(size: 12)
}

/// there are convenience inits() for UILabel, UITextView and UIButton 
let label = UILabel(font: .largeTitle)

// assigning a font can be done the .from() or 
let bodyLabel = UILabel()
bodyLabel.font = .from(body)
bodyLabel.font = Font.body.font()

```

To turn these items into `UIFont`, call `.from(.largeTitle)` or `Font.largeTitle.font()`

### UILabel, UITextView, UIButton convenience inits

`UIlabel`, `UITextView` and `UIButton` all have convenience helpers that take a `Font` and automatically enabled dynamic type when needed:

```
let label = UILabel(text: "Some Text", font: .largeTitle, color: label, alignment: .center)
let textView = UITextView(font: .body, color: .secondaryLabel)
let button = UIButton(font: .button.smaller.rounded)
```


### Modifiers

There are a lot of modifiers for composing fonts, some are shown in the example below:

```
let body = Font(size: 14, style: .body)

body.smaller // 1pt smaller
body.smaller(by: 5) // 5 pts smaller

body.larger // 1pt larger
body.larger(by: 5) // 5 pts larger

body.with(size: 12) // same font, but with size 12
body.with(weight: .bold) // same font, but bold
body.with(design: .rounded) // same font, but rounded
body.with(scalability: .fixed) // same font, but not scalable
body.with(traits: .italic) // same font, but italic only

body.bold.adding(traits: .italic) // same font, but italic and bold

body.bolder // a bolder font
body.rounded // a rounded font
body.thin // a thin font
body.italic // an italic font
body.fixed // a font that doesn't scale

```

### iOS Text Styles

There are also equivalents of all iOS text styles, under `.ios.`:
```
let label = UILabel(font: .ios.largeTitle)
let bodyLabel = UILabel(font: .ios.body)
etc
```
