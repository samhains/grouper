LikerInfo = React.createClass({
  render(){
    return (<span >
            <a 
              href={`/users/${this.props.liker.id}`}> 
              {this.props.liker.name } </a>
            </span>);
  }
});
