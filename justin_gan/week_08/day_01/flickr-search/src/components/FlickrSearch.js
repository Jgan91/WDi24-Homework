import React, { PureComponent } from 'react';
import jsonp from 'jsonp-es6'

class FlickrSearch extends PureComponent {
  constructor() {
    super();
    this.state = { images: [] };
    this.fetchImages = this.fetchImages.bind( this );
  }

  fetchImages(q) {
    console.log( 'search for', q, this );

    const flickrURL = 'https://api.flickr.com/services/rest/?jsoncallback=?';
    const flickrParams = {
      method: 'flickr.photos.search',
      api_key: '2f5ac274ecfac5a455f38745704ad084',
      text: q,
      format: 'json',
      per_page: 500
    }

    const generateURL = function (photo) {
      return [
        'http://farm',
        photo.farm,
        '.static.flickr.com/',
        photo.server,
        '/',
        photo.id,
        '_',
        photo.secret,
        '_q.jpg' // Change "q" for different sizes
      ].join('');
    }

    jsonp( flickrURL, flickrParams, { callback: 'jsoncallback' } ).then( ( results ) => {
      const images = results.photos.photo.map( generateURL );
      this.setState( { images: images } );
    } );
  }

  render() {
    return (
      <React.Fragment>
        <h1>FlickrSearch</h1>
        <SearchForm onSubmit={ this.fetchImages }/>
        <Gallery />
      </React.Fragment>
    );
  }
}

class SearchForm extends PureComponent {
  constructor( props ) {
    super( props );
    this.state = { query: '' };
    this._handleSubmit = this._handleSubmit.bind( this );
    this._handleInput = this._handleInput.bind( this );
  }

  _handleSubmit(e) {
    e.preventDefault();
    this.props.onSubmit( this.state.query );
  }

  _handleInput(e) {
    this.setState( { query: e.target.value } );
  }

  render() {
    return (
      <form onSubmit={ this._handleSubmit }>
        <input type="search" placeholder="Some text..." onChange={ this._handleInput } />
        <input type="submit" value="Go" />
      </form>
    )
  }
}

class Gallery extends PureComponent {
  render() {
    return (
      <h2>Gallery coming soon</h2>
    )
  }
}

export default FlickrSearch;
