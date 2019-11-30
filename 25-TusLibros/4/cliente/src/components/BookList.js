class BookListComponent extends React.Component {
  constructor(props) {
    super(props)
  }

	render() {
		const {
			cartID,
			bookList,
			onClickBook,
			onClickAdd,
			onClickSub,
			quantityHeading,
			classes,
		} = this.props
		
		return (
			<Table className={classes.table} aria-label="simple table">
				<TableHead>
					<TableRow>
						<TableCell>Title</TableCell>
						<TableCell>ISBN</TableCell>
						<TableCell align="center">{quantityHeading}</TableCell>
					</TableRow>
				</TableHead>
				<TableBody>
					{
						bookList.map((item, index) => (
							<TableRow key={index}>
								<TableCell>
									<Button onClick={onClickBook}>{item.title}</Button>
								</TableCell>
								<TableCell>{item.isbn}</TableCell>
								<TableCell align="center">
									<EditableBookQuantity cartID={cartID} isbn={item.isbn} quantity={0} />
								</TableCell>
							</TableRow>
						))
					}
				</TableBody>
			</Table>
    )
	}
}

const BookList = withStyles(styles, {
  withTheme: true
})(BookListComponent)
