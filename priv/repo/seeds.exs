alias MM.Repo
alias MM.Schema.{User}

michael = Repo.insert!(User.changeset(%User{}, %{name: "Michael", email: "michael@mm.org"}))
michelle = Repo.insert!(User.changeset(%User{}, %{name: "Michelle", email: "michelle@mm.org"}))
