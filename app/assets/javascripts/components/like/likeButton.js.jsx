var LikeButton = React.createClass({
  render(){
    var cx = React.addons.classSet;
    var classes = cx({
      'btn-primary': this.props.liked,
      'btn-small-like': (this.props.type === 'Comment') ? true : false
    });
    var likeText = (this.props.type === 'Post') ? 'Like' : '';
    return (
            <button 
              onClick={this.props.clickHandler} 
              className={`btn btn-default btn-xs like-btn ${classes}`}>
                <i className="glyphicon glyphicon-thumbs-up"></i>
                {likeText}
            </button>
           );
  }

});
