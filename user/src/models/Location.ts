import { Document, model, Model, Schema } from 'mongoose';

class Location {
    public static model: Model<Document> = model(
        'Location',
        new Schema({
            city: String,
            province: {
                type: String,
                maxlength: 2,
            },
            country: String,
        }).index({ city: 1, province: 1 }, { unique: true })
    );

    private location: Document;

    constructor(location: any) {
        const { city, province, country } = location;
        this.location = new Location.model({ city, province, country });
        this.location.save();
    }

    public getObjectID() {
        return this.location._id;
    }
}

export { Location };
