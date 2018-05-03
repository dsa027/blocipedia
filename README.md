---
title: Blocipedia
short-description: A Web-based, SPA Wiki-like creator written in AngularJS
---
<a href="https://blooming-wave-99055.herokuapp.com/">
  Heroku
</a>

![]( /assets/img/posts/GitHub-Mark-32px.png "GitHub")
[GitHub](https://github.com/dsa027/blocipedia)
{:.center}

{% highlight javascript%}
{% endhighlight %}

# Summary

  A Wiki-like Creator written with Rails

  - Registration emails are not yet working. You can test with:
    - dsa027@gmail.com, pwd: password
  - To upgrade the account, use the test card number: 4242 4242 4242 4242

# Explanation

  Blocipedia is a social, markdown-based Wiki-like creation tool.

  From the front page, the hero banner asks you to sign up for a free account that may be upgraded to a premium account. You may also sign in from here if you already have an account.

  To see a list of all wikis, click the Wikis link at the top left. This page shows wiki titles, wiki submission date, whether a wiki is public or private, and a snippet from the wiki. Only public wikis and your own private wikis and those you collaborate on are shown in the list. Click on a title to view the wiki. You may also create a new wiki here by clicking the New Wiki button.

  When viewing a wiki, you may click on buttons to Edit Wiki, Delete Wiki, and create a new wiki. The full wiki markdown is shown on this page.

  Editing a wiki and creating a new wiki look the same except the new wiki doesn't yet contain information. There's quite a bit on this page.
  - Title - the wiki title
  - Body - The wiki's markdown is entered here.
  - Private wiki (Premium only): check to take this wiki out of public view.
  - Save - publishes the wiki.
  - Preview - click the refresh button to see how the wiki markup will appear.
  - Collaborators (Premium only) - Search and select multiple current Blocipedia users to help you edit the wiki.

  To upgrade your Standard account to a Premium account, click on Upgrade Account at the top of any page. From here, just enter the a test Stripe credit card number (e.g., 4242 4242 4242 4242) after clicking on Pay with Card. You may now downgrade you account back to Standard.

  The application is generally broken down by
  - Welcome - Home
  + Registrations - Register for an account and process confirmation number from email. Uses Devise.
  - Wikis - Wiki CRUD
  - Collaborator  - Collaborator CRUD
  - Charges - Upgrade account/downgrade account. Uses Stripe.

# Problem

  This application is the second Rails application, Bloccit being the first. This application is complex and takes advantage of several technologies listed below.

# Solution

  This project shows the practical application of several technologies:
  - Rails
    - The entire application is written in Rails. Controllers, Helpers, Mailers, Models, Views, and Sqlite3/Postgresql for dev/prod are used.
  - Ruby
  - JavaScript - collaborator functions
  - jQuery - collaborator Ajax
  - Ajax
  - Devise - registration and email
  - Stripe - credit card processing
  - Select2 - collaborator multi-select
  - Bootstrap
  - HTML/CSS
  - Heroku
  - GitHub

# Results

  Devise isn't working correctly yet on Heroku. There are minor bugs to still fix and some enhancements would make the app even better.

# Conclusion
  After getting through the previous Bloccit project, Rails became a favorite and writing this application was challenging a great deal of fun.

  ToDos
  - Get Devise working on Heroku
