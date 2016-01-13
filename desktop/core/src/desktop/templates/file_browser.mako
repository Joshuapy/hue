## Licensed to Cloudera, Inc. under one
## or more contributor license agreements.  See the NOTICE file
## distributed with this work for additional information
## regarding copyright ownership.  Cloudera, Inc. licenses this file
## to you under the Apache License, Version 2.0 (the
## "License"); you may not use this file except in compliance
## with the License.  You may obtain a copy of the License at
##
##     http://www.apache.org/licenses/LICENSE-2.0
##
## Unless required by applicable law or agreed to in writing, software
## distributed under the License is distributed on an "AS IS" BASIS,
## WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
## See the License for the specific language governing permissions and
## limitations under the License.

<%!
from desktop import conf
from desktop.lib.i18n import smart_unicode
from django.utils.translation import ugettext as _
from desktop.views import _ko
%>

<%def name="fileBrowser()">
  <style>

    .fb-container {
      position: absolute;
      top: 0;
      bottom: 0;
      right: 0;
      left: 0;
      display: flex;
      flex-direction: column;
    }

    .fb-action-bar,
    .fb-header {
      flex: 0 0 auto;

      overflow: hidden;
      padding: 2px;
      clear: both;
    }

    .fb-header {
      border-bottom: 1px solid #f1f1f1;
      letter-spacing: 0.035em;
      font-size: 15px;
      color: #737373;
    }

    .fb-list {
      flex: 1 1 auto;
      overflow-y: scroll;
      overflow-x: hidden;
    }

    .fb-breadcrumb {
      display: inline-block;
    }

    .fb-folder-actions {
      display: inline-block;
      float: right;
      font-size: 25px;
      margin-right: 10px;
    }

    .fb-list ul {
      list-style: none;
      padding: 4px 0;
      margin: 0;
    }

    .fb-list li {
      clear: both;
      height: 35px;
      line-height: 35px;
      padding: 2px;
      margin: 0;
      color: #444;
      font-size: 13px;
    }

    .fb-list i {
      color: #666;
      font-size: 20px;
      margin-right: 8px;
      font-weight: lighter;
    }

    .fb-action {
      width: 25px;
      height: 40px;
      line-height: 40px;
      margin-left:5px;
    }

    .fb-primary-col {
      float: left;
      display: inline-block;
      height: 30px;
      line-height: 30px;
      vertical-align: middle;
      padding-left: 8px;
      text-overflow: ellipsis;
    }

    .fb-attr-group {
      float: right;
      display: inline-block;
      height: 30px;
    }

    .fb-attr-col {
      display: inline-block;;
      height: 30px;
      line-height: 30px;
      vertical-align: middle;
    }

    .fb-owner {
      width: 170px;
    }

    .fb-modified {
      width: 150px;
    }

    .hueBreadcrumbBar a {
      color: #338BB8 !important;
      display: inline !important;
    }

    .divider {
      color: #CCC;
    }
  </style>

  <script type="text/html" id="fb-template">
    <div class="fb-container">
      <div class="fb-action-bar">
        <h4>
          <div class="fb-breadcrumb">
              <ul class="nav nav-pills hueBreadcrumbBar">
                <li><a href="javascript:void(0);">Documents</a><span class="divider">&gt;</span></li>
                <li><a href="javascript:void(0);">Test folder</a></li>
              </ul>
          </div>
          <div class="fb-folder-actions">
            <a class="inactive-action" href="javascript:void(0);"><span class="fa-stack fa-fw fb-action"><i class="fa fa-file-o fa-stack-1x"></i><i class="fa fa-plus-circle fa-stack-1x" style="font-size: 14px; margin-left: 6px; margin-top: 6px;"></i></span></a>
            <a class="inactive-action" href="javascript:void(0);"><span class="fa-stack fa-fw fb-action"><i class="fa fa-folder-o fa-stack-1x" ></i><i class="fa fa-plus-circle fa-stack-1x" style="font-size: 14px; margin-left: 7px; margin-top: 3px;"></i></span></a>
            <a class="inactive-action" href="javascript:void(0);"><i class="fa fa-fw fa-times fb-action"></i></a>
            <a class="inactive-action" href="javascript:void(0);"><i class="fa fa-fw fa-users fb-action"></i></a>
            <a class="inactive-action" href="javascript:void(0);"><i class="fa fa-fw fa-download fb-action"></i></a>
            <a class="inactive-action" href="javascript:void(0);"><i class="fa fa-fw fa-upload fb-action"></i></a>
          </div>
        </h4>
      </div>
      <div class="fb-header">
        <div class="fb-primary-col">Name</div>
        <div class="fb-attr-group">
          <div class="fb-attr-col fb-owner">
            Owner
          </div>
          <div class="fb-attr-col fb-modified">
            Last Modified
          </div>
        </div>
      </div>
      <div class="fb-list">
        <ul>
          <li>
            <div class="fb-primary-col"><i class="fa fa-file-o fa-fw"></i> Filename</div>
            <div class="fb-attr-group">
              <div class="fb-attr-col fb-owner">me</div>
              <div class="fb-attr-col fb-modified">2015-10-11</div>
            </div>
          </li>
        </ul>
      </div>
    </div>
  </script>

  <script type="text/javascript" charset="utf-8">
    (function (factory) {
      if(typeof require === "function") {
        define('fileBrowser', [
          'knockout'
        ], factory);
      } else {
        factory(ko);
      }
    }(function (ko) {

      /**
       * @param {Object} params
       * @param {HueDirectory} params.currentDirectory - Observable holding the current directory
       * @constructor
       */
      function FileBrowser (params) {
        var self = this;
        self.currentDirectory = params.currentDirectory;
      }

      ko.components.register('file-browser', {
        viewModel: FileBrowser,
        template: { element: 'fb-template' }
      });
    }));
  </script>
</%def>