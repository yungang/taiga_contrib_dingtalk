###
# Copyright (C) 2014-2017 Andrey Antukh <niwi@niwi.nz>
# Copyright (C) 2014-2017 Jesús Espino Garcia <jespinog@gmail.com>
# Copyright (C) 2014-2017 David Barragán Merino <bameda@dbarragan.com>
# Copyright (C) 2014-2017 Alejandro Alonso <alejandro.alonso@kaleidos.net>
# Copyright (C) 2014-2017 Juan Francisco Alcántara <juanfran.alcantara@kaleidos.net>
# Copyright (C) 2014-2017 Xavi Julian <xavier.julian@kaleidos.net>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as
# published by the Free Software Foundation, either version 3 of the
# License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU Affero General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with this program. If not, see <http://www.gnu.org/licenses/>.
#
# File: dingtalk.coffee
###
debounce = (wait, func) ->
    return _.debounce(func, wait, {leading: true, trailing: false})


class DingtalkAdmin
    @.$inject = [
        "$rootScope",
        "$scope",
        "$tgRepo",
        "tgAppMetaService",
        "$tgConfirm",
        "$tgHttp",
        "tgProjectService"
    ]

    constructor: (@rootScope, @scope, @repo, @appMetaService, @confirm, @http, @projectService) ->
        @scope.sectionName = "Dingtalk" # i18n
        @scope.sectionSlug = "dingtalk"

        @scope.project = @projectService.project.toJS()
        @scope.projectId = @scope.project.id

        promise = @repo.queryMany("dingtalk", {project: @scope.projectId})

        promise.then (dingtalkhooks) =>
            @scope.dingtalkhook = {
                project: @scope.projectId,
                notify_userstory_create: true,
                notify_userstory_change: true,
                notify_userstory_delete: true,
                notify_task_create: true,
                notify_task_change: true,
                notify_task_delete: true,
                notify_issue_create: true,
                notify_issue_change: true,
                notify_issue_delete: true,
                notify_wikipage_create: true,
                notify_wikipage_change: true,
                notify_wikipage_delete: true
            }
            if dingtalkhooks.length > 0
                @scope.dingtalkhook = dingtalkhooks[0]

            title = "#{@scope.sectionName} - Plugins - #{@scope.project.name}" # i18n
            description = @scope.project.description
            @appMetaService.setAll(title, description)

        promise.then null, =>
            @confirm.notify("error")

    testHook: () ->
        promise = @http.post(@repo.resolveUrlForModel(@scope.dingtalkhook) + '/test')
        promise.success (_data, _status) =>
            @confirm.notify("success")
        promise.error (data, status) =>
            @confirm.notify("error")


DingtalkWebhooksDirective = ($repo, $confirm, $loading, $analytics) ->
    link = ($scope, $el, $attrs) ->
        form = $el.find("form").checksley({"onlyOneErrorElement": true})
        submit = debounce 2000, (event) =>
            event.preventDefault()

            return if not form.validate()

            currentLoading = $loading()
                .target(submitButton)
                .start()

            if not $scope.dingtalkhook.id
                promise = $repo.create("dingtalk", $scope.dingtalkhook)
                promise.then (data) ->
                    $analytics.trackEvent("dingtalk", "create", "Create dingtalk integration", 1)
                    $scope.dingtalkhook = data
            else if $scope.dingtalkhook.url
                promise = $repo.save($scope.dingtalkhook)
                promise.then (data) ->
                    $scope.dingtalkhook = data
            else
                promise = $repo.remove($scope.dingtalkhook)
                promise.then (data) ->
                    $scope.dingtalkhook = {
                        project: $scope.projectId,
                        notify_userstory_create: true,
                        notify_userstory_change: true,
                        notify_userstory_delete: true,
                        notify_task_create: true,
                        notify_task_change: true,
                        notify_task_delete: true,
                        notify_issue_create: true,
                        notify_issue_change: true,
                        notify_issue_delete: true,
                        notify_wikipage_create: true,
                        notify_wikipage_change: true,
                        notify_wikipage_delete: true
                    }

            promise.then (data)->
                currentLoading.finish()
                $confirm.notify("success")

            promise.then null, (data) ->
                currentLoading.finish()
                form.setErrors(data)
                if data._error_message
                    $confirm.notify("error", data._error_message)

        submitButton = $el.find(".submit-button")

        $el.on "submit", "form", submit
        $el.on "click", ".submit-button", submit

    return {link:link}

module = angular.module('taigaContrib.dingtalk', [])

module.controller("ContribDingtalkAdminController", DingtalkAdmin)
module.directive("contribDingtalkWebhooks", ["$tgRepo", "$tgConfirm", "$tgLoading", "$tgAnalytics", DingtalkWebhooksDirective])

initDingtalkPlugin = ($tgUrls) ->
    $tgUrls.update({
        "dingtalk": "/dingtalk"
    })
module.run(["$tgUrls", initDingtalkPlugin])
