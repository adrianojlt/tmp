<%@  taglib uri="/struts-tags" prefix="s"%>

<body>

	<div id="centered">


		<s:form action="selectedbooksLink" theme="simple">
			<center>
				<table id="grid">
					<thead>
						<tr>
							<th id="th-title">Book Title</th>
							<th id="th-author">Author</th>
							<th id="th-price">Price</th>
						</tr>
					</thead>


					<tbody>

						<s:iterator value="bookList" id="book">
							<tr>

								<td><s:checkbox name="selectedBooks" fieldValue="%{bookId}" />
									<s:property value="#book.bookTitle" /></td>
								<td><s:iterator value="#book.authors" id="number">
										<s:if test="%{#book.id == #number.bookId}">
											<s:property value="#number.firstName" />
											<s:property value="#number.lastName" />
										</s:if>
									</s:iterator></td>
								<td><s:property value="price" /></td>

							</tr>
						</s:iterator>

					</tbody>

				</table>
			</center>
			<br>
			<s:submit value="Add to Cart" />

		</s:form>

	</div>
</body>