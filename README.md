# Blocipedia

A Wikipedia-style web application built with Ruby on Rails, Blocipedia incorporates 3rd party gems like [Devise](#devise---authentication), [Pundit](#pundit---authorization), and [Redcarpet](#redcarpet).

![Blocipedia landing page](https://tboddyspargo.github.io/img/blocipedia_landing_1.png)

# Devise - Authentication

Blocipedia uses [Devise](https://github.com/plataformatec/devise) to create a user authentication model with many of the features that one would expect of a modern web application, including account confirmation, password changing,

# Pundit - Authorization

[Pundit](https://github.com/varvet/pundit) provides an authroization layer within Blocipedia to make sure a users access is appropriate.

# Redcarpet

Blocipedia leverages [Redcarpet](https://github.com/vmg/redcarpet) to provide the ability to use markdown syntax when writing wikis.

![Wiki edit page](https://tboddyspargo.github.io/img/blocipedia_wiki_edit_1.png)

# Bootstrap 4

The UI for Blocipedia is created almost entirely by leveraging [Bootstrap v4](https://getbootstrap.com/docs/4.0/getting-started/introduction/) classes with very little customization. It provided an excellent CSS class set to build an organized and appealing user experience with minimal effort (and minimal creativity).

# Stripe

Stripe integration is used to provide functionality for different account types of 'standard' and 'premium'. Blocipedia was created for learning purposes only, however, so it uses Stripe in test mode (no real financial transactions will occur).

![Wiki premium upgrade](https://tboddyspargo.github.io/img/blocipedia_go_premium_2.png)

# Try it

[Hosted on Herkoku](https://muyleche-blocipedia.herokuapp.com/)
