<%@taglib uri="/struts-tags" prefix="s"%>

<div class="leftbar">
	<ul id="menu">
		<li><div>
				<a class="link1" href="<s:url action="homeLink"/>"><span
					class="label" style="margin-left: 15px;">Home</span> </a>
			</div></li>
		<li><div>
				<a class="link1" href="<s:url action="allBooksLink"/>"><span
					style="margin-left: 15px;" class="label">All Books</span></a>
			</div></li>
		<li><div>

				<span class="label" style="margin-left: 15px;">Categories</span>
			</div>
			<ul>

				<li><s:form action="booksByCategoryLink">

						<s:select name="category" list="#session['categoryList']"
							listValue="categoryDescription" listKey="id" />
						<s:submit value="Select" />
					</s:form> <a class="label" href=""><span class="label"
						style="margin-left: 30px;"></span></a></li>

			</ul></li>
		<li><div>
				<span class="label" style="margin-left: 15px;">Contact Us</span>

			</div></li>
	</ul>
	<s:form action="searchByKeywordLink" class="search">
		<s:textfield name="keyword" size="12" />
		<s:submit value="Search" />
	</s:form>
	<span class="tooltip_message">?</span>

</div>