# Guide for publication

1. Create a branch with the name of the version `x.x.x`

2. Change the version in `version.rb` file and in `ReachFiveApi`
```ruby
$VERSION = 'x.x.x'
```
```swift
let defaultParams: [String: String] = [
    "platform": "ios",
    // TODO: read from the version.rb. Either directly or indirectly from IdentitySdkCore.h, Info.plist...
    "sdk": "x.x.x",
    "device": deviceInfo,
]
```

3. Run `./update.sh` to update the dependencies
```shell
./update.sh
```

4. Update the `CHANGELOG.md` file

5. Submit and merge the pull request

6. Add git tag `x.x.x` to the merge commit
```sh
git tag x.x.x
```

6. Push the tag
```sh
git push origin x.x.x
```

7. The CI will automatically publish this new version

8. Finally, draft a new release in the [Github releases tab](https://github.com/ReachFive/identity-ios-sdk/releases) (copy & paste the changelog in the release's description).
