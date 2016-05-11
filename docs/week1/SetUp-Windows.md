# Windows 7 or later
---
## Installing Git Desktop
Downloading and installing GitHub Desktop

You can install GitHub Desktop on Microsoft Windows 7 or later .

Visit the [GitHub Desktop download page.](https://desktop.github.com/)

Choose **Download for Windows.**

In your computer's **Downloads** folder, double-click **GitHub Desktop.**
In the pop-up window, click **Install.**
After the program has been installed, click **Run.**

On your computer, open the **Git Shell** application.
Tell Git your name so your commits will be properly labeled.
```
git config --global user.name "YOUR NAME"
```
Tell Git the email address that will be associated with your Git commits. The email you specify should be the same one found in your [email settings.](https://help.github.com/articles/adding-an-email-address-to-your-github-account/) To keep your email address hidden, see ["Keeping your email address private".](https://help.github.com/articles/keeping-your-email-address-private_)

```
git config --global user.email "YOUR EMAIL ADDRESS"

```


## Installing Ruby

Visit the [Ruby Download page.](http://rubyinstaller.org/downloads/)

Download either Ruby 2.2.4 or Ruby 2.2.4 (x64) depending on your OS architecture.  

Once you've installed Ruby open a command prompt as Administrator and install the AWS SDK. This will take a few minutes per command:
```
gem update --system
gem install aws-sdk
```
When complete close out of your command prompt.

## Installing AWS CLI

Go to the [AWS CLI download page](https://aws.amazon.com/cli/) and download the appropriate installation file for your architecture type.

In your computer's **Downloads** folder, double-click **AWSCLI64.MSI**
In the pop-up window, click **Install.**

---

## References:
GIT: https://help.github.com/articles/set-up-git/#platform-windows

RUBY: http://rubyinstaller.org/downloads/

AWS CLI: https://aws.amazon.com/cli/
