// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails

//= require jquery
//= require activestorage
//= require cocoon

import "controllers"
import {GistClient} from "gist-client";

import Rails from '@rails/ujs';

window.GistClient = new GistClient()



Rails.start();
