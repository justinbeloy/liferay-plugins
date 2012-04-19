<%--
/**
 * Copyright (c) 2000-2012 Liferay, Inc. All rights reserved.
 *
 * This library is free software; you can redistribute it and/or modify it under
 * the terms of the GNU Lesser General Public License as published by the Free
 * Software Foundation; either version 2.1 of the License, or (at your option)
 * any later version.
 *
 * This library is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
 * FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more
 * details.
 */
--%>

<%@ include file="/init.jsp" %>

<%
User selUser = (User)request.getAttribute("user.selUser");
%>

<aui:model-context bean="<%= selUser %>" model="<%= User.class %>" />

<h3><liferay-ui:message key="details" /></h3>

<aui:fieldset column="<%= true %>" cssClass="aui-w50">
	<aui:input name="firstName" />
	<aui:input name="middleName" />
	<aui:input name="lastName" />
	<aui:input name="jobTitle" />
</aui:fieldset>

<aui:fieldset column="<%= true %>" cssClass="aui-w50">
	<div id="<portlet:namespace />userDetailsDialog">
		<c:if test="<%= selUser != null %>">

			<%
			Group controlPanelGroup = GroupLocalServiceUtil.getGroup(themeDisplay.getCompanyId(), GroupConstants.CONTROL_PANEL);

			long controlPanelPlid = LayoutLocalServiceUtil.getDefaultPlid(controlPanelGroup.getGroupId(), true);
			%>

			<liferay-portlet:renderURL plid="<%= controlPanelPlid %>" portletName="<%= PortletKeys.USERS_ADMIN %>" refererPlid="<%= plid %>" var="editUserPortraitURL" windowState="<%= LiferayWindowState.POP_UP.toString() %>">
				<portlet:param name="struts_action" value="/users_admin/edit_user_portrait" />
				<portlet:param name="redirect" value="<%= currentURL %>" />
				<portlet:param name="p_u_i_d" value="<%= String.valueOf(selUser.getUserId()) %>" />
				<portlet:param name="portrait_id" value="<%= String.valueOf(selUser.getPortraitId()) %>" />
			</liferay-portlet:renderURL>

			<liferay-ui:logo-selector
				defaultLogoURL="<%= UserConstants.getPortraitURL(themeDisplay.getPathImage(), selUser.isMale(), 0) %>"
				editLogoURL="<%= editUserPortraitURL %>"
				imageId="<%= selUser.getPortraitId() %>"
				logoDisplaySelector=".user-logo"
				showBackground="<%= false %>"
			/>
		</c:if>
	</div>
</aui:fieldset>

<aui:script use="aui-base">
	window['<%= PortalUtil.getPortletNamespace(PortletKeys.USERS_ADMIN) %>changeLogo'] = function (logoURL) {
		var avatarDialog = A.one('#<portlet:namespace />userDetailsDialog .avatar');

		if (avatarDialog) {
			avatarDialog.attr('src', logoURL);
		}

		var avatarSidebar = A.one('#so-sidebar .profile-image img');

		if (avatarSidebar) {
			avatarSidebar.attr('src', logoURL);
		}
	}
</aui:script>