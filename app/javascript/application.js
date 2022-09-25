// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import { Turbo } from "@hotwired/turbo-rails"
Turbo.session.drive = false
import "controllers"
import "popper"
import "bootstrap"
//= require jquery3
//= require popper
//= require bootstrap-sprockets
import * as bootstrap from "bootstrap"
