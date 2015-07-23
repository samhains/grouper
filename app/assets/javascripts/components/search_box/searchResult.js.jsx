var SearchResult = React.createClass({
  handleClick(e) {
    this.props.handleClick(this.props.user.username);
  },
  render (){
    return (
          <a onClick={this.handleClick} 
            className="list-group-item cursor-pointer" >
              {this.props.user.name} ( {this.props.user.username} )
          </a>
    );
  }
});
