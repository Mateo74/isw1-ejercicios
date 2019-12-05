class TicketComponent extends React.Component {
    constructor(props) {
      super(props)
    }
  
    render() {
      return (
        <div>
          Ticket!
        </div>
      )
    }
  }
  
  // Add style
  const TicketView = withStyles(styles, {
    withTheme: true
  })(TicketComponent)
  