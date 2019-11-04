import { Document, model, Model, Schema, Types } from 'mongoose';

const REQUIRED_FIELDS: string[] = ['city', 'country'];

const LocationModel: Model<Document> = model(
    'Location',
    new Schema({
        city: String,
        province: {
            type: String,
            maxlength: 2,
        },
        country: String,
    }).index({ city: 1, country: 1 }, { unique: true })
);

async function createLocation(location: any): Promise<Document> {
    const { city, province, country } = location;
    const loc = new LocationModel({ city, province, country });
    return await loc.save();
}

async function getLocationID(location: any): Promise<Types.ObjectId> {
    const { city, country } = location;
    const objectId: Types.ObjectId = await new Promise((resolve, reject) => {
        LocationModel.findOne({ city, country }, (err: any, loc: Document) => {
            if (err) {
                reject(err);
            }
            resolve(loc._id);
        });
    });
    return objectId;
}

function locationIsValid(location: any): boolean {
    let isAllValid: boolean = true;
    for (const field of REQUIRED_FIELDS) {
        isAllValid = isAllValid && location.hasOwnProperty(field) && location[field];
    }
    return isAllValid;
}

export { createLocation, getLocationID, locationIsValid };
