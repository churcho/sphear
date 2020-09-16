import MainView from './main';

export default function loadView(viewPath) {
    if (!viewPath) {
        return new MainView();
    }

    const ViewClass = require('./' + viewPath + '.js');
    return new ViewClass.default();
}